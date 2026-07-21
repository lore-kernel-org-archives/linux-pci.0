Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F793BB699;
	Tue, 21 Jul 2026 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623073; cv=none; b=ryDgllKtqXlwct75SGKdR2hmul4svuIKduFbj1sm2f+helwk5s0/b7NzhDP2gEeiB1naCPut3cpTyfnr9xxCCoTKbIfPSyIYBi17DyDnCfhWpuFRLkjfzUVQx549SekBOoCw6qow7UHJayTVOy8qVgQqUAiNU5iutypPokQAhck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623073; c=relaxed/simple;
	bh=O4QY+t3MpXNgvHl0r8m0U3NraUi11T43NouAyvjm0fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBz9pN/HTqRJdfZsW4moiuFTr0aK7/rb0DkQurko8jZTpVCfvlfSFkFM8W0vW5j4SRy46iTEapVzP2+HnCdi9dVKD5WNEGxCJwP/5+GzzlthyckStkAvSIPTn7GKMT3rshUqetd/RcdpiTo8ca+nUQN3VNd1XwTdPDtWmY/7Lfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 695A11062F;
	Tue, 21 Jul 2026 10:37:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 641F6614B893; Tue, 21 Jul 2026 10:37:40 +0200 (CEST)
Date: Tue, 21 Jul 2026 10:37:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Robert Richter <rrichter@amd.com>, linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Alejandro Lucero <alucerop@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Gregory Price <gourry@gourry.net>,
	Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Oliver O'Halloran <oohall@gmail.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 11/13] PCI: Cache PCI DSN into pci_dev->dsn during
 probe
Message-ID: <al8v1PRFw1_MjjGk@wunner.de>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-12-terry.bowman@amd.com>
 <alsk97jVqw9jbRdQ@wunner.de>
 <91e35807-9483-45f5-b4a8-0388aa48ff6f@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91e35807-9483-45f5-b4a8-0388aa48ff6f@amd.com>

On Mon, Jul 20, 2026 at 10:48:06AM -0500, Bowman, Terry wrote:
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -90,7 +90,6 @@ extern int pciehp_poll_time;
>   */
>  struct controller {
>         struct pcie_device *pcie;
> -       u64 dsn;
> 

Please drop the kernel-doc for this struct member as well.

> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -1086,8 +1086,6 @@ struct controller *pcie_init(struct pcie_device *dev)
>         }
>  
>         pdev = pci_get_slot(subordinate, PCI_DEVFN(0, 0));
> -       if (pdev)
> -               ctrl->dsn = pci_get_dsn(pdev);
>         pci_dev_put(pdev);
>

Please drop the pci_get_slot() + pci_dev_put() as well,
they're obviously superfluous now.

> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -73,7 +73,6 @@ int pciehp_configure_device(struct controller *ctrl)
>         down_read_nested(&ctrl->reset_lock, ctrl->depth);
>  
>         dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
> -       ctrl->dsn = pci_get_dsn(dev);
>         pci_dev_put(dev);
>

Same here.

Thanks,

Lukas
