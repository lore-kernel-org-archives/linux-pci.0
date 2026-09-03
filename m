Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47143636A;
	Thu,  3 Sep 2026 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433673; cv=none; b=Px5MkbysPK8Cbe0vxVERaz930IiBgj8s6tcsUtRfNTe3RiTCQnQjvnS6H5O+mT+KHcWxx+RjPr8WVU+/wcJdXGa4wq6izgCOi2oa8QLHjryN16vbDX7lpRd/S8aGchMGHaw7bkrh0yfG26q7pEYYTN7sgAw6BKKmW77rmI5ZI2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433673; c=relaxed/simple;
	bh=EryYC6IIO+b2JMw0cCqtaSQgy32cQJPFGPK8fCv6aYI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q7fse9Qrrr14TbWNlse1XZYq87mMPUix9WlJL7rsKBwrEJm7+elVb2j2aO67MVufatAiKgLHwK99iwSoKlHDsWIMAefCIM7U7rlvWFo2er4v/7u7KQFamLNG6pxeLz36rlnOg4ouuguSZ9pwBCbezUNyELmoYIA0hwkmGW/YGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBOh460S; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBOh460S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788433672; x=1819969672;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EryYC6IIO+b2JMw0cCqtaSQgy32cQJPFGPK8fCv6aYI=;
  b=bBOh460SlCAvtYEqTbx2zDDcwl6qg8jxi4aKEVWl9r5qRRAPS6eI0O8F
   9rx0WFDl3l1BcTL8ld4auXYWZ9AWPP1MjRuAZ19xsdyCpuPNaYwZw1zoF
   QnU+bznjndRG6XoutAy/TaD4FBlq6qkIggZuo7WzwigeYgV8NlIAgoPTw
   pBXHLSW7mBiD+jL6dT8aO6LPGhlr2q+TcAh+pJoHQaEoLs0C68GVfuA8w
   uQrhjbiCyeYgo7lz5JmtPRObCJRKacqFsRYZIerf2PQbT1Yh8WLWhgxg2
   75he4U0ej1rFkTnK5eDXBH/Wd5yGuMskMMOws4nmDejZRtMooo3JrVsdZ
   Q==;
X-CSE-ConnectionGUID: DC5BLU6KQamDHWsbUntSug==
X-CSE-MsgGUID: nU2qUyKKTkS2zwcQ2kG/xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="106280142"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="106280142"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:07:52 -0700
X-CSE-ConnectionGUID: ZMzv7EaGQYSHv47tp7k0Bw==
X-CSE-MsgGUID: neGp8020TE2bmdt3A9FbxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="269159014"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.119])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:07:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 3 Sep 2026 14:07:43 +0300 (EEST)
To: Wei Wang <wei.w.wang@hotmail.com>
cc: bhelgaas@google.com, jgg@nvidia.com, jic23@kernel.org, error27@gmail.com, 
    kwilczynski@kernel.org, rdunlap@infradead.org, akpm@linux-foundation.org, 
    bp@alien8.de, alex@shazbot.org, kevin.tian@intel.com, 
    manivannan.sadhasivam@oss.qualcomm.com, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 1/6] PCI: Validate ACS control bits against device-specific
 ACS capabilities
In-Reply-To: <SI2PR01MB43931558B27C956BDBDCE0C6DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Message-ID: <7cab6f02-d557-abcf-63a8-28db43504acd@linux.intel.com>
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com> <SI2PR01MB43931558B27C956BDBDCE0C6DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 3 Sep 2026, Wei Wang wrote:

> The ACS control validation used the kernel's full set of ACS control bits,
> which allowed users to request ACS features that the device does not
> support. Because hardware silently ignores these unsupported bits, users
> have no indication that their config_acs= request was partially
> ineffective.
> 
> Validate the requested ACS control bits against dev->acs_capabilities so
> that only device-supported ACS controls are accepted. Mask the capability
> with GENMASK_U16(6, 0) to select only the currently defined ACS control
> bits (0-6). Higher bits in the capability structure (e.g. the egress
> control vector size in bits 8-15) do not correspond to control bits in
> the ACS control register. Add a debug message to report which unsupported
> bits were ignored.
> 
> __pci_config_acs() is also called from disable_acs_redir_param(), which
> passes a hardcoded acs_mask (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC) that
> does not need validation. Gate the new check on !acs_mask so it only
> fires for the config_acs_param path, which always invokes
> __pci_config_acs() with acs_mask == 0 and builds the actual mask from
> user input.
> 
> Also move the check after the device is matched, since the ctrl bits apply
> only to the matched device.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/pci/pci.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..2af679111a9b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -910,6 +910,7 @@ struct pci_acs {
>  static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>  			     const char *p, const u16 acs_mask, const u16 acs_flags)
>  {
> +	u16 valid_ctrl = dev->acs_capabilities & GENMASK_U16(6, 0);

This looks a step backwards.

These bits are surely named so this mask should be a composite of those 
define names, either done here or through another define (likely the 
latter is better).

>  	u16 flags = acs_flags;
>  	u16 mask = acs_mask;
>  	char *delimit;
> @@ -955,12 +956,6 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>  			}
>  		}
>  
> -		if (mask & ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
> -			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)) {
> -			pci_err(dev, "Invalid ACS flags specified\n");
> -			return;
> -		}
> -
>  		ret = pci_dev_str_match(dev, p, &p);
>  		if (ret < 0) {
>  			pr_warn_once("PCI: Can't parse ACS command line parameter\n");
> @@ -983,6 +978,13 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>  	if (!pci_dev_specific_disable_acs_redir(dev))
>  		return;
>  
> +	if (!acs_mask && (mask & ~valid_ctrl)) {
> +		pci_dbg(dev, "Ignoring unsupported ACS bits: %#06x\n",
> +			mask & ~valid_ctrl);
> +		mask &= valid_ctrl;
> +		flags &= valid_ctrl;
> +	}
> +
>  	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
>  	pci_dbg(dev, "ACS flags = %#06x\n", flags);
>  	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
> 

-- 
 i.

