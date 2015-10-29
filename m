Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60913 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbbJ2Vnx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Oct 2015 17:43:53 -0400
Date: Thu, 29 Oct 2015 16:43:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Duyck <aduyck@mirantis.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iov: Variable and loop cleanup for sriov_disable and
 sriov_enable
Message-ID: <20151029214349.GC921@localhost>
References: <20151027204607.14626.59671.stgit@localhost.localdomain>
 <20151027205233.14626.98836.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151027205233.14626.98836.stgit@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,

On Tue, Oct 27, 2015 at 01:52:33PM -0700, Alexander Duyck wrote:
> This patch is just a minor cleanup to go through and group all of the
> variables into one declaration instead of a long string of single
> declarations for each int.  It also changes the direction for a couple
> loops as we are able to loop with less code this way as testing against 0
> can be done as a part of the decrement operation.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/pci/iov.c |   13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index cecc242c1af0..c0fc88fa7c4d 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -241,15 +241,11 @@ int __weak pcibios_sriov_disable(struct pci_dev *pdev)
>  
>  static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  {
> -	int rc;
> -	int i;
> -	int nres;
>  	u16 offset, stride, initial;
>  	struct resource *res;
>  	struct pci_dev *pdev;
>  	struct pci_sriov *iov = dev->sriov;
> -	int bars = 0;
> -	int bus;
> +	int rc, i, nres, bars, bus;

I don't have a strong opinion on combining the declarations to one line,
and I would apply it if you wanted to do the same for the whole file
at once, in a patch by itself.

>  	if (!nr_virtfn)
>  		return 0;
> @@ -271,8 +267,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	if (!offset || (nr_virtfn > 1 && !stride))
>  		return -EIO;
>  
> -	nres = 0;
> -	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> +	for (nres = 0, bars = 0, i = PCI_SRIOV_NUM_BARS; i--;) {

But I don't agree that this is easier to read.  I suppose it could be
a tiny bit more efficient, but I think the benefit to the reader of
the usual "for (i = 0; i < limit; i++)" loop is larger.

>  		bars |= (1 << (i + PCI_IOV_RESOURCES));
>  		res = &dev->resource[i + PCI_IOV_RESOURCES];
>  		if (res->parent)
> @@ -366,13 +361,13 @@ err_pcibios:
>  
>  static void sriov_disable(struct pci_dev *dev)
>  {
> -	int i;
>  	struct pci_sriov *iov = dev->sriov;
> +	int i = iov->num_VFs;
>  
>  	if (!iov->num_VFs)
>  		return;
>  
> -	for (i = 0; i < iov->num_VFs; i++)
> +	while (i--)
>  		virtfn_remove(dev, i, 0);

I do like the change to remove devices in the reverse order as we
added them.  But I'm really partial to the way a "for" loop keeps all
the loop control in one spot.  So I would apply a patch that made it
look like this:

  for (i = iov->num_VFs - 1; i >= 0; i--)
    virtfn_remove(dev, i, 0);

>  	pcibios_sriov_disable(dev);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
