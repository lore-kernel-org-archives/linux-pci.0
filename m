Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 28 Oct 2015 13:43:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Duyck <aduyck@mirantis.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iov: Update virtfn_max_buses to validate offset and
 stride
Message-ID: <20151028184324.GA10008@localhost>
References: <20151027204607.14626.59671.stgit@localhost.localdomain>
 <20151027205215.14626.93504.stgit@localhost.localdomain>
 <20151028163216.GA2927@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151028163216.GA2927@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 28, 2015 at 11:32:16AM -0500, Bjorn Helgaas wrote:
> Hi Alex,
> 
> Thanks a lot for cleaning this up.  I think this is a great
> improvement over what I did.
> 
> On Tue, Oct 27, 2015 at 01:52:15PM -0700, Alexander Duyck wrote:
> > This patch pulls the validation of offset and stride into virtfn_max_buses.
> > The general idea is to validate offset and stride for each possible value
> > of numvfs in addition to still determining the maximum bus value for the
> > VFs.
> > 
> > I also reversed the loop as the most likely maximum will be when numvfs is
> > set to total_VFs.  In addition this makes it so that we loop down to a
> > value of 0 for numvfs which should be the resting state for the register.
> > 
> > Fixes: 8e20e89658f2 ("PCI: Set SR-IOV NumVFs to zero after enumeration")
> > Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> 
> I'd like to squash this together with my patch instead of having fixes
> on top of fixes.  What do you think of the following?  (This applies
> on top of 70675e0b6a1a ("PCI: Don't try to restore VF BARs")).
> 
> 
> commit c20e11b572c5d4e4f01c86580a133122fbd13cfa
> Author: Alexander Duyck <aduyck@mirantis.com>
> Date:   Wed Oct 28 10:54:32 2015 -0500
> 
>     PCI: Set SR-IOV NumVFs to zero after enumeration
>     
>     The enumeration path should leave NumVFs set to zero.  But after
>     4449f079722c ("PCI: Calculate maximum number of buses required for VFs"),
>     we call virtfn_max_buses() in the enumeration path, which changes NumVFs.
>     This NumVFs change is visible via lspci and sysfs until a driver enables
>     SR-IOV.
>     
>     Iterate from TotalVFs down to zero so NumVFs is zero when we're finished
>     computing the maximum number of buses.  Validate offset and stride in
>     the loop, so we can test it at every possible NumVFs setting.  Rename
>     virtfn_max_buses() to compute_max_vf_buses() to hint that it does have a
>     side effect of updating iov->max_VF_buses.
>     
>     [bhelgaas: changelog, rename, reverse sense of error path]
>     Fixes: 4449f079722c ("PCI: Calculate maximum number of buses required for VFs")
>     Based-on-patch-by: Ethan Zhao <ethan.zhao@oracle.com>
>     Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index ee0ebff..120cfb3 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -54,24 +54,33 @@ static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
>   * The PF consumes one bus number.  NumVFs, First VF Offset, and VF Stride
>   * determine how many additional bus numbers will be consumed by VFs.
>   *
> - * Iterate over all valid NumVFs and calculate the maximum number of bus
> - * numbers that could ever be required.
> + * Iterate over all valid NumVFs, validate offset and stride, and calculate
> + * the maximum number of bus numbers that could ever be required.
>   */
> -static inline u8 virtfn_max_buses(struct pci_dev *dev)
> +static int compute_max_vf_buses(struct pci_dev *dev)
>  {
>  	struct pci_sriov *iov = dev->sriov;
> -	int nr_virtfn;
> -	u8 max = 0;
> +	int nr_virtfn = iov->total_VFs;
>  	int busnr;
>  
> -	for (nr_virtfn = 1; nr_virtfn <= iov->total_VFs; nr_virtfn++) {
> -		pci_iov_set_numvfs(dev, nr_virtfn);
> +	pci_iov_set_numvfs(dev, nr_virtfn);
> +
> +	while (nr_virtfn--) {
> +		if (!iov->offset || !iov->stride)
> +			goto err;

I think we have a minor problem here.  In sriov_enable(), we return an
error if "nr_virtfn > 1 && !iov->stride", so it's legal for stride to
be zero if NumVF is 1.  Here we don't allow that.  Sec 3.3.10 says:

  Note: VF Stride is unused if NumVFs is 0 or 1.  If NumVFs is greater
  than 1, VF Stride must not be zero."

So I think we should allow "stride == 0" here when NumVFs is 1.

> +
>  		busnr = pci_iov_virtfn_bus(dev, nr_virtfn - 1);

I think this loop management is slightly wrong: I don't think we ever
compute busnr for the highest VF because we always decrement nr_virtfn
after calling pci_iov_set_numvfs(), and then we subtract one again.
E.g., if Total VFs is 8, the VFs are numbered VF0..VF7, and we have
this, which doesn't check VF7:

  nr_virtfn = iov->total_VFs                 # nr_virtfn == 8
  pci_iov_set_numvfs(..., nr_virtfn)         # passes 8 (correct)
  while (nr_virtfn--) {
                                             # nr_virtfn == 7 in loop body
    pci_iov_virtfn_bus(..., nr_virtfn - 1)   # passes 6 (wrong)

> -		if (busnr > max)
> -			max = busnr;
> +		if (busnr > iov->max_VF_buses)
> +			iov->max_VF_buses = busnr;
> +
> +		pci_iov_set_numvfs(dev, nr_virtfn);
>  	}
>  
> -	return max;
> +	return 0;
> +
> +err:
> +	pci_iov_set_numvfs(dev, 0);
> +	return -EIO;
>  }

Here's my new proposal:

  static int compute_max_vf_buses(struct pci_dev *dev)
  {
          struct pci_sriov *iov = dev->sriov;
          int nr_virtfn, busnr, rc = 0;

          for (nr_virtfn = iov->total_VFs; nr_virtfn; nr_virtfn--) {
                  pci_iov_set_numvfs(dev, nr_virtfn);
                  if (!iov->offset || (nr_virtfn > 1 && !iov->stride)) {
                          rc = -EIO;
                          goto out;
                  }

                  busnr = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
                  if (busnr > iov->max_VF_buses)
                          iov->max_VF_buses = busnr;
          }

  out:
          pci_iov_set_numvfs(dev, 0);
          return rc;
  }

