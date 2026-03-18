Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBE93EB816;
	Wed, 18 Mar 2026 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849059; cv=none; b=ssn9Gup/MBoRY+FbFslWzom7u82CIVwkOSmOQYW2ykc4sEc6SbU02hv6w8atSthk+nxHQfcM123Lu5d58PrsHlBoef/dH+gtNpisy8i9+1SmP9NFLUZveygEqqRj0sSFJCpkkaUY1zStR7srOu6DsaV/UGnrtgv3LC0g8ZwuhU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849059; c=relaxed/simple;
	bh=+lnjUkf0OHEY53UwRr8h7v/oOtyDAetw7DI1iPHt9uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o35tdwc1xM9zJFnFDYIR0t+sAK90+ThumG4eBfwJA02uahsbS+TUKxLb9MqMj6A8b4lB2SEmMAAhYZ28KCJetGaIxeQmrblNXhVu+wFh7FqmticMYIH9BPZXu11fj04nxeVN5oCqdTovEcW4D9yH8VXzIqriWSQeMamcMZq+ztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1n2O9jy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1n2O9jy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E07C2BCAF;
	Wed, 18 Mar 2026 15:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773849059;
	bh=+lnjUkf0OHEY53UwRr8h7v/oOtyDAetw7DI1iPHt9uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1n2O9jyso3dRNfr2RL7B/BoUToKVIyLaPL8YERp/Gjvx3V6RZZrVmOHHRwYpvrKq
	 HT6GYgSxGZvmeI8s05wE85MTrDk0kYKpONf6U+vyVc5KkRsSIyusrBw9J/QD05wt2a
	 yO2dD+pvRncyx8QPa2DTHddBv72di/lHTp3xvBsshy+BqK+cckrphgENS1SlML2eNu
	 8VRd90d/qtkDqBzglq2dKW2zzCRlxowbIt+SKpRnPTmzBZVdUAkXNd4gnrsonelGGZ
	 gTfmwoaCU+EGnF3wSyBFgsN3WlAZRnRnP4UTv0w0FGO3Gm/P2I7HPjql5UoJR+568D
	 i4Yc5FIj7Lt3w==
Date: Wed, 18 Mar 2026 16:50:53 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Koichiro Den <den@valinux.co.jp>, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: endpoint: pci-epf-test: Handle -ENOSPC in
 subrange map test
Message-ID: <abrJ3X7BIU3In-bm@ryzen>
References: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
 <20260318-skip-bar_subrange-tests-if-enospc-v1-2-f1a49534ebea@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-skip-bar_subrange-tests-if-enospc-v1-2-f1a49534ebea@foss.st.com>

On Wed, Mar 18, 2026 at 03:46:28PM +0100, Christian Bruel wrote:
> Report pci_epc_set_bar() -ENOSPC failure with the
> STATUS_BAR_SUBRANGE_SETUP_NOSPC status bit. This can be used to
> skip the subrange test if there is not enough iATU resources to
> allocate it.
> 
> Link: https://lore.kernel.org/linux-pci/20260317152707.GA85951@bhelgaas/T/#m87e4c24173097a0ea70195b71aab294ad8d6c283

I would drop the link.


> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 14e61ebe1f116ce04789b6f4c3e965296701ec53..6437f08f0cd4bd4645e380c915b7cf81e66b7c35 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -54,6 +54,7 @@
>  #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
>  #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
>  #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
> +#define STATUS_BAR_SUBRANGE_SETUP_NOSPC		BIT(18)

Perhaps STATUS_BAR_SUBRANGE_SETUP_SKIP ?

>  
>  #define FLAG_USE_DMA			BIT(0)
>  
> @@ -903,6 +904,8 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
>  		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
>  		bar->submap = old_submap;
>  		bar->num_submap = old_nsub;
> +		if (ret == -ENOSPC)
> +			status |= STATUS_BAR_SUBRANGE_SETUP_NOSPC;
>  		kfree(submap);
>  		goto err;
>  	}

Here you will have both STATUS_BAR_SUBRANGE_SETUP_NOSPC and
STATUS_BAR_SUBRANGE_SETUP_FAIL set.

Usually, we only have one bit set.


Perhaps something like:

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 582938b7b4f1..36e5d22f79ab 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -895,6 +895,10 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
                bar->submap = old_submap;
                bar->num_submap = old_nsub;
                kfree(submap);
+               if (ret == -ENOSPC) {
+                       status |= STATUS_BAR_SUBRANGE_SETUP_SKIP;
+                       goto err_status_set;
+               }
                goto err;
        }
        kfree(old_submap);
@@ -918,6 +922,7 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
 
 err:
        status |= STATUS_BAR_SUBRANGE_SETUP_FAIL;
+err_status_set:
        reg->status = cpu_to_le32(status);
 }



This patch should probably be 1/3.


Kind regards,
Niklas
