Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732816132A;
	Fri, 22 May 2026 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779423047; cv=none; b=J077FdvFzPPdlld8UMeJvObH8GEyw+HMXpcYv+6XS1wcR79gvC5BRTL/4cVcwhcFbNJiOR4mSZdycqVYz0m4v8Yvj6w0FWPX2GLdh19Ltf9DuO95J3cV4VBQr8YavrQ5cJx/Y829nA7TZWTxnTMxPGQGm5o9gTS4vBsSIRYYcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779423047; c=relaxed/simple;
	bh=x7tpEPFe9S8TYODodcuy0xic3AWq0BuUVw6gDhJ19No=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjKjRqQBWSGy3iTCfwA8CREn58gkagC3/qbiGKnZqldzuQmH7ydDRb3G0GvtoTZETqQj6gK7Biz9DNI9UxMFGMhmCOIPQgPxFfAhvkRBNq109MtNQh6byVSVnPXhM6dfbSbTXiLPwX3RWO9XODWxYcnujfbQotk5tRGF7MfYFhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=dZP3S/Xk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g0WNUc/x; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="dZP3S/Xk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g0WNUc/x"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 76E181400107;
	Fri, 22 May 2026 00:10:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 22 May 2026 00:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779423043;
	 x=1779509443; bh=1U8w6BlH4UZVbbvLihqiM4iof8tue0zeE+C/qaxNAfI=; b=
	dZP3S/XkpOCke/XasGtUGb97rPwtSUkrlcQHT6P5/d1lXW/RiSoq6tEo/uywmsjG
	4xpJbbRnzRg7wLuuVb4c4ffoI/jrdydH+izwQXTkTRBVSrbMIT54a7UiezGsWXmB
	yvye/r0v7OQf7ktd5xQgVzKMsoq6OpO0wB23h8F+Wk8lFU3W1dCR+xS8AR9GE4cK
	SHzPbnDKJxP6pDhHfUZDCOE7G/rbT8j6gmZeff7edL+g4Mo+RSGnlV8+i7ccbZ04
	6/QeLG9fOxDp+y1QkoUxyk9j9L8jDRLGWauE3mAWCwprT9BCudZmkJrQxnNJ89bi
	2QEd/iRAkP5WUwB72xmQOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779423043; x=
	1779509443; bh=1U8w6BlH4UZVbbvLihqiM4iof8tue0zeE+C/qaxNAfI=; b=g
	0WNUc/xi97Q7oLlbN4C+f1vDDA8CAxJmj3MTJX1PL1JAyew4RtHJpQS3lgIvZsRm
	Qtftj8lDGTLW7hJWL5v4O9bP1+epxnsl7vwE9t7m+Kten6N5fcnA763eHYIi7Oks
	rZ+B/MlgZqEEPFkZdk6FYYmx7Pur/s0iz9HhfIO25a12y9LFBCjCkVOsHipJcdFX
	ooqGQov4zFrA8RhtKl2HHp3U8+/LQb4dKFPNiNlvFvj5yianuAUwVVUkOcaBWX+v
	aFEd47WffdHjR34z/pbyvyBlirkK6CEENGPVWttdq/tIfmmxf85LbGeX9xLZ5caN
	EZP8C4jz8sCng/Uc+Vofw==
X-ME-Sender: <xms:QtcPaqwcjrAqKsm0qsvv4pmKHbbuvXpA6BdY-V0wvspAkoEAti5mYQ>
    <xme:QtcPakhDTdNza08JhDgcVi8EodE-TwrX1qtMSGvhqP5DwNBL9eO7Es_6PA4V_-03G
    2iiVarQUe8QIx88ih4d5cGRKazQpM-9dSk0g71oyJdMlZ7SsbBTZQ>
X-ME-Received: <xmr:QtcPalqZBtASaqYopQ7IZZro5PWb_U5F8ovpEQoKSoiJVEW-RH9TXgOYlRk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurgifvghird
    gtohhmpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohepfigrthhh
    shgrlhgrrdhvihhthhgrnhgrghgvsegrrhhmrdgtohhmpdhrtghpthhtohephhgvlhhgrg
    grsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfigvihdrhhhurghnghdvsegrmhgu
    rdgtohhmpdhrtghpthhtohepfigrnhhgiihhohhuudeshhhishhilhhitghonhdrtghomh
    dprhgtphhtthhopeifrghnghihuhhshhgrnhduvdeshhhurgifvghirdgtohhmpdhrtghp
    thhtoheplhhiuhihohhnghhlohhngheshhhurgifvghirdgtohhmpdhrtghpthhtohepkh
    hvmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QtcPajj6cuJptqTgF1t25xsmWbT7jQydft3We6YFv2rHYAELoP64GA>
    <xmx:QtcPavP0LcPBaEn_hjWavMZO9wmY4WG6WtE--cFR62ho2E4r1oYRlg>
    <xmx:QtcPalwI2au_Tlks0KHj0UeizKW9Qq8ex5wpKHzop-nlKHPj3ffcyQ>
    <xmx:QtcPappwDG5Qb7JwE6S9U6RiysqMPPG7f1Bu5XJv9xHPSjK8Qj0kVA>
    <xmx:Q9cPaodYpcXvOYucIGLFy98pWt8ttR2ePa6pNOlQQ002EXnI1d8m3L-2>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 00:10:41 -0400 (EDT)
Date: Thu, 21 May 2026 22:10:33 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
 <wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
 <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v11 2/5] PCI/TPH: Export pcie_tph_get_st_modes() for
 external use
Message-ID: <20260521221033.11df345d@shazbot.org>
In-Reply-To: <20260518071701.25177-3-fengchengwen@huawei.com>
References: <20260518071701.25177-1-fengchengwen@huawei.com>
	<20260518071701.25177-3-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 15:16:58 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Export the helper to retrieve supported PCIe TPH steering tag modes so
> that drivers like VFIO can query and expose device capabilities to
> userspace.
> 
> Add stub functions for pcie_tph_get_st_table_size() and
> pcie_tph_get_st_table_loc() when !CONFIG_PCIE_TPH.
> 
> Add tph_cap validation for pcie_tph_get_st_modes() and
> pcie_tph_get_st_table_loc() to prevent invalid PCI configuration
> space access when TPH is not supported.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/tph.c       | 19 +++++++++++++++++--
>  include/linux/pci-tph.h |  7 +++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 877cf556242b..ba31b010f67a 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -145,15 +145,27 @@ static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
>  	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
>  }
>  
> -static u8 get_st_modes(struct pci_dev *pdev)
> +/**
> + * pcie_tph_get_st_modes - Get supported Steering Tag modes
> + * @pdev: PCI device to query
> + *
> + * Return:
> + *  Bitmask of supported ST modes (PCI_TPH_CAP_ST_NS, PCI_TPH_CAP_ST_IV,
> + *                                 PCI_TPH_CAP_ST_DS)
> + */
> +u8 pcie_tph_get_st_modes(struct pci_dev *pdev)
>  {
>  	u32 reg;
>  
> +	if (!pdev->tph_cap)
> +		return 0;
> +
>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
>  	reg &= PCI_TPH_CAP_ST_NS | PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS;
>  
>  	return reg;
>  }
> +EXPORT_SYMBOL(pcie_tph_get_st_modes);
>  
>  /**
>   * pcie_tph_get_st_table_loc - Return the device's ST table location
> @@ -168,6 +180,9 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  {
>  	u32 reg;
>  
> +	if (!pdev->tph_cap)
> +		return PCI_TPH_LOC_NONE;
> +
>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
>  
>  	return reg & PCI_TPH_CAP_LOC_MASK;
> @@ -395,7 +410,7 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  
>  	/* Sanitize and check ST mode compatibility */
>  	mode &= PCI_TPH_CTRL_MODE_SEL_MASK;
> -	dev_modes = get_st_modes(pdev);
> +	dev_modes = pcie_tph_get_st_modes(pdev);
>  	if (!((1 << mode) & dev_modes))
>  		return -EINVAL;
>  
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index be68cd17f2f8..5772d48ea444 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> +u8 pcie_tph_get_st_modes(struct pci_dev *pdev);
>  #else
>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>  					unsigned int index, u16 tag)
> @@ -41,6 +42,12 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  { return -EINVAL; }
> +static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
> +{ return 0; }
> +static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
> +{ return 0; }

Functionally the same, but this should be PCI_TPH_LOC_NONE for
consistency.

It seems there are a couple instances above where reg is passed
uninitialized to pci_read_config_dword() where the return value is
untested and the function could operate on garbage stack data.
Existing issue.  Thanks,

Alex

> +static inline u8 pcie_tph_get_st_modes(struct pci_dev *pdev)
> +{ return 0; }
>  #endif
>  
>  #endif /* LINUX_PCI_TPH_H */

