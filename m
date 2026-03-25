Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4485A34DB6D;
	Wed, 25 Mar 2026 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774480426; cv=none; b=ez5kdRtmW53v5AT/0GfmOVffAX0kG39Jsegooau8zPtpyKpH1H7eFHm5lcNauGc8ODEHS6K5V6K/C4J0sTG+pksxANkCkw0rur82ZB7oyNJwVajTOUjC7RDVemligr+PG7uwEkyX6F1zkWBiafowq39an0ThVP9IPezw9GVoUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774480426; c=relaxed/simple;
	bh=6HOi28c0aIsZQhT8sVNi8T1x2rw2HK7r7jexGLskZ5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lpmXOAmA8uM5S5AiPkYjqBW1bjblUKFBpxJgYzGjGeljvoeo9lv/Xcqx8wW0g1nDk0KaAJuh+2z6LfU8AT2H5EdIagrBcABIvE66NYVMnxAfXZg+IWJ+csTlU7JHFmsE55Af2xQggXwW4LxJ5Le7kanHXZxQr8tczdx1i2FbgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7j6QyFf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7j6QyFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD25EC4CEF7;
	Wed, 25 Mar 2026 23:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774480425;
	bh=6HOi28c0aIsZQhT8sVNi8T1x2rw2HK7r7jexGLskZ5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=i7j6QyFfV4EDmQQsY0gJwgpsIW7ADhhYgGnyo8je+pZf/Yd1/B6CSVyfqsiGz5whw
	 ffi5t6lwmD73ikTBg4EWjDEh8WdW0XprkdwnHJsz0VO6ETGA7mmy0gNFFDKvQlzplP
	 mVeoq1VreB4lz1/RKR4DFbZJ8FyS3vZ1boOSmPiVM/bPleVXHxEEpInuJg5mP/MyFB
	 F5htIIPnERsMGLVuolqa8UZcItUTh0ekV4PoSoKgsr96fDtqm2RVYvDPbDGGvEu42B
	 tdjEKu5BUx7ahAJDO+rjjuyxNWMVkkWYRXpVaUgrelTRl7IvIJ6sVYrlkuTtugFytx
	 5zvSEuGK+u7MQ==
Date: Wed, 25 Mar 2026 18:13:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Askar Safin <safinaskar@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Chris Li <chrisl@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	kexec@lists.infradead.org, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>,
	Marco Elver <elver@google.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3 03/24] PCI: Require Live Update preserved devices are
 in singleton iommu_groups
Message-ID: <20260325231344.GA1293155@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323235817.1960573-4-dmatlack@google.com>

On Mon, Mar 23, 2026 at 11:57:55PM +0000, David Matlack wrote:
> Require that Live Update preserved devices are in singleton iommu_groups
> during preservation (outgoing kernel) and retrieval (incoming kernel).
> 
> PCI devices preserved across Live Update will be allowed to perform
> memory transactions throughout the Live Update. Thus IOMMU groups for
> preserved devices must remain fixed. Since all current use cases for
> Live Update are for PCI devices in singleton iommu_groups, require that
> as a starting point. This avoids the complexity of needing to enforce
> arbitrary iommu_group topologies while still allowing all current use
> cases.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index bec7b3500057..a3dbe06650ff 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -75,6 +75,8 @@
>   *
>   *  * The device must not be a Physical Function (PF).
>   *
> + *  * The device must be the only device in its IOMMU group.
> + *
>   * Preservation Behavior
>   * =====================
>   *
> @@ -105,6 +107,7 @@
>  
>  #include <linux/bsearch.h>
>  #include <linux/io.h>
> +#include <linux/iommu.h>
>  #include <linux/kexec_handover.h>
>  #include <linux/kho/abi/pci.h>
>  #include <linux/liveupdate.h>
> @@ -222,6 +225,31 @@ static void pci_ser_delete(struct pci_ser *ser, struct pci_dev *dev)
>  	ser->nr_devices--;
>  }
>  
> +static int count_devices(struct device *dev, void *__nr_devices)
> +{
> +	(*(int *)__nr_devices)++;
> +	return 0;
> +}
> +
> +static int pci_liveupdate_validate_iommu_group(struct pci_dev *dev)
> +{
> +	struct iommu_group *group;
> +	int nr_devices = 0;
> +
> +	group = iommu_group_get(&dev->dev);
> +	if (group) {
> +		iommu_group_for_each_dev(group, &nr_devices, count_devices);
> +		iommu_group_put(group);
> +	}
> +
> +	if (nr_devices != 1) {
> +		pci_warn(dev, "Live Update preserved devices must be in singleton iommu groups!");
> +		return -EINVAL;
> +	}
> +
> +	return 0;

I assume the requirement is that there *is* an iommu_group and also
that dev is the only member.  If so, I think the intent would be a
little clearer as:

    group = iommu_group_get(&dev->dev);
    if (!group)
      goto no_group;

    iommu_group_for_each_dev(group, &nr_devices, count_devices);
    iommu_group_put(group);

    if (nr_devices == 1) {
      return 0;

  no_group:
    pci_warn(...);
    return -EINVAL;

> +}
> +
>  int pci_liveupdate_preserve(struct pci_dev *dev)
>  {
>  	struct pci_dev_ser new = INIT_PCI_DEV_SER(dev);
> @@ -232,6 +260,10 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
>  	if (dev->is_virtfn || dev->is_physfn)
>  		return -EINVAL;
>  
> +	ret = pci_liveupdate_validate_iommu_group(dev);
> +	if (ret)
> +		return ret;
> +
>  	guard(mutex)(&pci_flb_outgoing_lock);
>  
>  	if (dev->liveupdate_outgoing)
> @@ -357,7 +389,7 @@ int pci_liveupdate_retrieve(struct pci_dev *dev)
>  	if (!dev->liveupdate_incoming)
>  		return -EINVAL;
>  
> -	return 0;
> +	return pci_liveupdate_validate_iommu_group(dev);
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_retrieve);
>  
> -- 
> 2.53.0.983.g0bb29b3bc5-goog
> 
