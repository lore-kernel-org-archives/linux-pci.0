Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE484119F7;
	Fri, 25 Sep 2026 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362172; cv=none; b=hw/EPNu7JvQS3K2i5RHa9m44IXalwtBQ2rb4q2/8tpI/ou84WYh7M/AzcBOfDKXQvTj7skmEOpgjn7Aho/Yt51/+V7OIJ+TgLlEJM5ZhPwcSWLx6SYlCFspwkWykFWTxP2FExeb7a6vMNyl2wTewnJtlR/WwghZxxmhKlstv3qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362172; c=relaxed/simple;
	bh=eizWWAfnysxrEC0WZUfzHve6Du+WJHYq+Y6A6ISqgyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGZrqzW1BUVLGWmcam9J5u8JYqyRCqZxQKdkewdbitStCewrm0dTQ8FhgmfseFSG9FJn1JiJ8Q5uRTZsScgEkeUXxI/cUGMbBJ6I0XyRdjYA28VOA6BkYc9yl+a57RpbgUqpRStnhaCxI8HuHOpKwIMbwjh+h1zjdN6WNHk5fnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 6F7DF10E4C;
	Fri, 25 Sep 2026 20:49:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 53F226078B58; Fri, 25 Sep 2026 20:49:26 +0200 (CEST)
Date: Fri, 25 Sep 2026 20:49:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Zhu Qiyu <qiyuzhu2@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Avoid dropping hotplug interrupts due to
 stale HPIE
Message-ID: <arbCNu_Ozv2j_CEv@wunner.de>
References: <20260924101929.143806-1-qiyuzhu2@amd.com>
 <20260925114635.192878-1-qiyuzhu2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925114635.192878-1-qiyuzhu2@amd.com>

On Fri, Sep 25, 2026 at 11:46:35AM +0000, Zhu Qiyu wrote:
> pciehp_isr() uses the Hot-Plug Interrupt Enable (HPIE) bit in
> ctrl->slot_ctrl to reject interrupts when hotplug interrupts are
> disabled.  This check is needed because hotplug can share an interrupt
> with other sources, including native PME.
> 
> However, ctrl->slot_ctrl is updated from hardware on every Slot Control
> Register read-modify-write.  A firmware change to HPIE can race with an
> unrelated driver operation, such as an LED indicator update:

Firmware is not allowed to change the Slot Control Register once it has
granted control of PCI Express Native Hot Plug Control to the operating
system.

From PCIe r3.3 table 4-6 bit 0:

   "Additionally, after control is transferred to the operating system,
    firmware must not update the state of hot plug slots, including the
    state of the indicators and power controller."

Are you seeing this on a real-world system or is it an LLM-generated
hallucination?

If the former, please consider fixing this through a firmware update.

Thanks,

Lukas
