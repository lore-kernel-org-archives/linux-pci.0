Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.232.15.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794115128;
	b=xEeakCN4YdvXIuuCvoZ291PMdl+l3vQ4jBJH37OboNFxoe4ZYdAhUf9RIMT6ONzvr3gg
	 zZ2YiCXTVNVZOwVFoya7LwJT6zhO1ItnWs+mD9qaUyahAlxnxyYG5UGN184taRebX83qx
	 rn8xYWoWi+SIey79pImhq2rDU5ZoBqN6eruUIT08tAdq9NmwaSbtu8f+dhqwRuNhnmw8G
	 QO0vsB/OJpTBpzEiZ4UYz1QBNCAXhk+V8tiqSRFG9VmrqSOEkVt1PXo0AJbVvg338lUq8
	 ST1wgvnYdeOekN8398S4UpoyuKKD4Ly9cP2TVcfCT1NcS9Ip+C+twGzrcWp9dwG3WCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794115128;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q7Bfjkkm4tTsSxgf0XNVqkmYHoK3twG9SMLsLcNULmo=;
	b=mrsDHcExK/29I4anYiyxgptIlLTQPs7GlYPt4Ysoq3lk3tELN4Ax0BaD1ixwEjIzCMED
	 oPqisYGFNoWG/zdYCtk8bVp5iITm0JPOIWpCBRkDMXAVjATHeOoQ9CLhEIb0+4qTiHJ3G
	 yASePpqjuXhxrKw69hk1KW+dWws+Ty+V8WCx5G0spzTm93ReYHO2IUQcSXpb8hW/ioUjH
	 w5bLMPR2fen6G53bsk8ztEdt2jcS8oZKRpapruV3P4rqSOgl5vydmRHGW/pmwnJiyO1J6
	 K0FsIlYoHUm8pqvnI2jAPhkugQSVGrUmPKR1XhqatAGvKtL7E3h8pz1lLRuh0YF2Nug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=unwrap.rs;
	spf=pass smtp.mailfrom=unwrap.rs;
	dkim=pass header.d=unwrap.rs header.i=@unwrap.rs header.a=rsa-sha256 header.s=202503r header.b=J9VikNHf;
	dkim=pass header.d=unwrap.rs header.i=@unwrap.rs header.a=ed25519-sha256 header.s=202503e header.b=l4uuMeG2;
	arc=none smtp.remote-ip=172.232.15.166
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5EE606A31A;
	Sun,  8 Nov 2026 05:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB5EE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unwrap.rs header.i=@unwrap.rs header.a=rsa-sha256 header.s=202503r header.b=J9VikNHf;
	dkim=pass header.d=unwrap.rs header.i=@unwrap.rs header.a=ed25519-sha256 header.s=202503e header.b=l4uuMeG2
DKIM-Signature: v=1; a=rsa-sha256; s=202503r; d=unwrap.rs; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From:Content-Type; t=1794115121; bh=Q7Bfjkkm4t
	TsSxgf0XNVqkmYHoK3twG9SMLsLcNULmo=; b=J9VikNHf51Ts2Bm0THqTs28U7OQBSBUtb/hex
	AsvcZrDTM3yDw8KO1LgYfY7LNKQPDzyK6uQ6xF7+ShUOnZqkIL4fXYr0UiiFFqQXgC6SSow0POL
	iugyJ/XT9WwyzE3avk7UADz5gZbAHUxG3vFwY+Hgl+KZ3pA5rE+PZrMPZ2lFc4TFNSv8CIJxmsv
	rPx0jSwmvjUiGGaed3iFtn8wI8Qs3NsiDEgH9Vg+LqR4kfzbmx1QRkY0Ua6gHgaPgHhtWILpLFY
	GDaI3LyQ9JEYlfhMDU461ji6KRZSosmruwbg8hAWQ6dbkYEYeUgqWEliHEDdnZsy/oFsbdenxMg
	Q1H3g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202503e; d=unwrap.rs; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From:Content-Type; t=1794115121; bh=Q7Bfjkkm4t
	TsSxgf0XNVqkmYHoK3twG9SMLsLcNULmo=; b=l4uuMeG22fYIzY4+8H2mk1LE5ddlOhH77QlGu
	hh05avwOZDtY/4SZPam0ipEL3gou4NrGbNErmOA70p+PYP5AQ==;
From: Cole Leavitt <cole@unwrap.rs>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <westeri@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] thunderbolt: Don't resume the software CM if the host controller is gone
Date: Sun,  8 Nov 2026 00:18:29 -0500
Message-ID: <20261108051829.152803-1-cole@unwrap.rs>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019042920.GX176164@black.igk.intel.com>
References: <20261018163750.130470-1-cole@unwrap.rs> <20261018163910.132231-1-cole@unwrap.rs> <20261018163910.132231-2-cole@unwrap.rs> <20261019042920.GX176164@black.igk.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mika,

On Mon, Oct 19, 2026 at 06:29:20AM +0200, Mika Westerberg wrote:
> This is not supposed to happen with SW CM systems. I've seen a couple of
> times Lenovo BIOS has the PCIe root port hotplug enabled and that's against
> what the Barlow Ridge BIOS configuration checklist says. Please check if
> there is newer BIOS (Lenovo has been fixing these) and of not report it to
> Lenovo.

Thanks, and sorry for the slow reply. You were right. Every oops I
captured was on BIOS N4FET30W (1.11), where pciehp was bound to the
Barlow Ridge root port (0000:80:1b.4, "pciehp: Slot(25)"). The machine
now runs N4FET52W (1.33), and that root port no longer gets the hotplug
service: only PME, AER and bandwidth control are bound to it. So the
slow-link "replacement" that started all of this cannot happen there
anymore.

Please drop this patch.

For 1/2: the trigger on this machine is gone with the new BIOS, but the
ordering problem is in pciehp itself. A device replacement detected in
pciehp_resume_noirq() still starts the removal from the IRQ thread in
the middle of the noirq phase, unserialized against ->resume_noirq() of
the drivers below the port (on today's mainline, fa4ad798f6f6,
pciehp_core.c:310 calls pciehp_request(), and pciehp_ctrl.c:145 wakes
the IRQ thread directly unless pciehp_poll_mode is set). Bjorn, Lukas:
if that is not worth changing without a reproducer on correctly
configured hardware, I will drop 1/2 as well.

Thanks,
Cole
