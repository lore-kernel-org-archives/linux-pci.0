Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333124;
	b=FMNlLALipMp+E+4X57BvwFGEhLNr9EEWGt52HcTUIKS4AFwPwqa0jKaW/YQnjaCHuM/1
	 PwFifdwZgiZ63qlPfA+NhZbFpScA9knmYZk9aWSJHf7vryo1rewciJ9b1IQJ3IEJrvmGH
	 oqTppo0j3SS4mPyJboriG3l9yI6WCxsWjWrKu4s+/WMYFKzc4tsY9nOdRP7K7OYk0eKQ6
	 AuBLhyAl/lO5IUQt6WOYS6Aw3rUNXg7UNhMkHJ13OTXqSHow1IFvin/+jOWtVOtzWTSNP
	 Qqc+XMD44k/jBU90PvupiRAGn856/Hsg2wbDcIORkwkf9vPzWwSZTXBdzw07ZhlxU/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=WuksYLyMaEMm2HbqRs5Yxt96t5m3C7Tw90Zl9efnSF4=;
	b=LKHw62iNvAGbE3xVpwsW2yMRRDkZUlexV1f/3dwkJ0qprfcf7wGlAXGAuGFvmHBS8eSI
	 cm2PTg5tubqb/b0V/nIkHzUyyIQ7s59hGBX46crlN41eA36JzVnk2sLf6xJLDc6k+V7YV
	 rJ9QHXmffuZkXGGkLkZH7XUluXJl8Nlxr3K3peKUbjrIdCovaDb6eHzeNFXwxQhSQKMCA
	 8GHNpovL4pfpgz9/S4x2nOBZhrwcEvVzq4Iu6AlcnrZnlowLU1qpifBbkas6w8dMHJRwG
	 mAhqHUUscKuAsENvKTPLOL1ghE4vU3SPMnvydD0PS6NdMfFfTP4/Sy0LS8YFrXPlN9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IYqpa7XZ;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646B606A320
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 17:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6646B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IYqpa7XZ
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ed34e33913so10869715ad.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 09:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794333124; x=1794937924; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WuksYLyMaEMm2HbqRs5Yxt96t5m3C7Tw90Zl9efnSF4=;
        b=IYqpa7XZ9FXuF7RFmZfem2i/qAMPkUgqOU0xEeiZROhcUObt7ylDU/9PEjrr4UpTZZ
         Zi67ogD6Be817Yv7d30fzln/bmhfL2sazvRFPIcjU17xvjwya9BeLKPfiB2lP5uZpTl5
         t0/tjGIbNQr4b1u4TNIh1c8H158eNp6SOs+TJSPCDQr1NApKgZnzj4e9RPnOLvehcGdI
         0qFTXbdZfpRjyX9N8HNJvPifUNGNcMHlkV+tcxON0vV8JR9e62P0hCWI07b/ptOAua4n
         ZcKFYQZY/etuxDivMa0pYnurNyl9YBNnSt0beLBtBfKHAzHRAWdSgIKFeBpOvJ/g7N1y
         evqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333124; x=1794937924;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WuksYLyMaEMm2HbqRs5Yxt96t5m3C7Tw90Zl9efnSF4=;
        b=QWT/E+9YD9ak0ai/MO99NaOX5FZNJHG41HrN+FH2RgziasYFtsiaGpdxlS753pxI4N
         fJFJAzdqhKvzF3tfzeYBjv9c4ZM2uJxldLMn7UA0ZTClz9ioldCz53Z4NWWLIwHVgrIq
         SzRQk/d45Vvff8qNxChQjlZeWCZipz2cf9sbzKjCl1BY9Fn9K1CliNgmprWd89HQrFnP
         3WJber0HEcqer3rN7D4Z/+3Vo+Go7qOshttiDVESkqPcOOt/Lsl2zY8RunDiRNBBYb/x
         ISfx5ZW3ZyL/Snu6ybPgAS4LypH0cuFQKu+5XsdvzyQQX9DkXZ96UHwyEq3p8yLhCmdW
         xk1g==
X-Forwarded-Encrypted: i=1; AL+hErF/wQvWuZckaW/DlsP5K8FlGt9r66+mnAlvNmhluPEkAm6mT02SmyUaL+0Tu+Y2PoFOGZUt46iKfLE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/q7d4TXM6V7gQUdApOPXXRwK9Wo+UnzVSnO4IKI6WC5nepugku
	2nA7kSjFB4uCwLDOu0b4vuT+wlKNW8813x2P6dLcpR46dkPPA+6E7BDupMczN13HOB6T5vWkh6F
	o56qj1OYTN2pizWCnmhbi5fyexZvw65jwmA==
X-Received: from plzu6.prod.google.com ([2002:a17:902:82c6:b0:2eb:809:b8ac])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e851:b0:2df:9497:3c89 with SMTP id d9443c01a7336-2edb91f89d9mr32092425ad.59.1794333123478;
 Tue, 10 Nov 2026 09:52:03 -0800 (PST)
Date: Tue, 10 Nov 2026 17:52:02 +0000
In-Reply-To: <81a1fed9c86e3954b1807f7425f98d210503a28f.camel@linux.ibm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261012-pcie-hotplug-nullref-v1-1-6e21c2e89ea4@google.com>
 <sashiko-outbox-168676@kernel.org> <20261109215339.1841223-1-rathodpriyank@google.com>
 <avLsH4a-l_uxlWfU@wunner.de> <81a1fed9c86e3954b1807f7425f98d210503a28f.camel@linux.ibm.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110175203.1307769-1-rathodpriyank@google.com>
Subject: Re: [PATCH] PCI: pciehp: Fix NULL pointer dereference in pciehp_configure_device()
From: Priyank Rathod <rathodpriyank@google.com>
To: Lukas Wunner <lukas@wunner.de>, Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ricky Wu <ricky_wu@realtek.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 10, 2026 at 04:43:52PM +0100, Niklas Schnelle wrote:
> On Tue, 2026-11-10 at 11:04 +0100, Lukas Wunner wrote:
> > Are you actually observing a crash in practice because of a missing NULL
> > pointer check?
>
> FWIW we (s390) do not use pciehp we use our own s390_pci_hpc for
> hotplug. I'd be interested if this comes out of a real issue or just an
> LLM worry too though.

Hi Lukas, Niklas,

No crash was observed in practice -- this came from static inspection,
and even reproducing it in QEMU requires patching QEMU's pcie-root-port
to bypass its Function 0 hotplug checks in addition to
hypervisor_isolated_pci_functions() returning true.

Since this isn't reachable on unmodified hypervisors and Terry's pending
patch removes ctrl->dsn and those lines altogether, please consider this
patch withdrawn.  Thanks for the pointer and clarification!

Best regards,
Priyank
