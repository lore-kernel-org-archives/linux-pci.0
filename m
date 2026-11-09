Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261221;
	b=PdBxku3jd5B7fHRk9YLEpANEfmjsSUzpIzGelW4pk+T0mJihEyBqOWzI0YZ0n5oabyk6
	 cfWDvTo0nqX5is/5fyMDmgXDcip9JSQBz9gaxxwY5vtUyeAsoWl0rfAVFl5xhNP4T0NGl
	 RceFPjBdWpee0hixGgAhB8flFRlU/YILmDOX6HCkEoQSuoV7yTZ+nrXjU3kNZ+I+6J00J
	 Zfy6ITupg1oXiq4986HzLXqFhtFzZKgi5IIzbFcwH73lSxPaG2ttias9tMu9YRS9bt8Dv
	 4pK1lqBFJC4Zw1BHiQlDgzJZ47d6ljaYCW4N/bTSL8gIPhOrwDx7vPMRtNdI6e1TFrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=rxNh3ezBlJBDubzQ4HVqSLZQeSKGPHcJoMnCtAFhXGQ=;
	b=kZ/JcIhByx+AM+9+J1yYo4Oy19RyJbeX1wnzIyEShMmVoivrjRo0sNQnAkjbGLBGj1TL
	 vVzjk+4TmQt2FXZiPLQbf5avkUUy5gMkVY7GYLV8PlOVqYkGDSQTQnhGeof7jH9Ud4CyJ
	 dwlpawb6y24p+9XBppJXQLvwreYDNt2hLcyjM4um9QN/trIsyXed711HHnDImVP2DRISD
	 imCBHc599dktAR87lweIQgDxJJTDzbYc9XUGHolKHGjiw2czkM7Oq1h3hdvO9MCJGOi2/
	 f1Yf69kSQpcZE61KS3cuk2T4yeODOycoRZRBHg0LgOu2/OV7dMhyveo/JjotiipLMPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="bW/KbGOi";
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD217606A31C
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 21:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD217606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bW/KbGOi
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b0a528ca65so1303476a91.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 13:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794261220; x=1794866020; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rxNh3ezBlJBDubzQ4HVqSLZQeSKGPHcJoMnCtAFhXGQ=;
        b=bW/KbGOinaXs2YkmP5nmcEDXKol7Ua3Zre6o0EHDN57H8jyUrItYmj3RoeYL+uOC82
         1vpPYTnbYFFyHJ9rAUeaNZ3+GhkvzlCiyb/tcsskL/WqQDjkZ79HhqcIwJD6kf1MBgln
         55Dp685/SX6dP+3HRAyw6lKCrAOXWJHG8hGgFVXoPXHcM7acGl/AQ1YlJCOXomUDF5IY
         sFROaw+1/iG93roJuNb2SRnxXSFbjah6HWvBRrrCQ67xTAnNY66Mv7PNXeK8YO1DQi5D
         3g/gHcNFNku5FElfgYhKDJPK130+ADdUY+psgL+iqWqu03oVISrHFwvf9Tl0S4conRUr
         ru5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794261220; x=1794866020;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rxNh3ezBlJBDubzQ4HVqSLZQeSKGPHcJoMnCtAFhXGQ=;
        b=XmSeQAKWJpInPi73n+h+fp/zJrxQo8uaq7QaEL8Pqf1iPXmM2XdjY/ZYp76tkKBaP4
         St6eJV+Su0LyqUPySB5xg4S0UgarwgJtDhscGto9cqbob/HRrymp5cGkFKX+G2RXR76s
         BEb0ECebJGNHkwYasP5T21RfD++lf/w4X+XzZlo025dbRA7HqdX9ai5xsob3F2MsQF0R
         jId8n44Z1o7I0IFerIObh8LGVW4EJAZXuAoIL98KxVb3Zx/lOl0n/qdGzMaw5vUUoXgN
         nyerOqvtfIHbVELGKOXx77Fy40NpDOPJ83PwuCoZveVRvbKC7TkL9sBViY3s0kCVx1KU
         KE5g==
X-Forwarded-Encrypted: i=1; AL+hErEJdkLvCSxjp9EvBtWiRHnJsxkCpPvJT+UQSvR30QjTeBPh5/27RBF6HSOZOua/jAoYClPXhf+eBcM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uQ5LoU3v3JF5mM3wdYzMKxu6uhbK1doxhBj7PYU3CX9i/jmEw
	jPbMOVL7J6cyTDdPvD5OHJZ7nEVRHePO8LLgK6u0kDE3ZHXJQVgQ3mSHTZzvdHIQugjw89yFF8E
	mKc0nQSANMNI8hB3wmLYj02i0slN0duhcoA==
X-Received: from pgfd22-n2.prod.google.com ([2002:a05:6a02:6556:20b0:cc9:f7f0:57fc])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4cce:b0:396:41d1:cbc7 with SMTP id 98e67ed59e1d1-3b166aef2b6mr990801a91.3.1794261219882;
 Mon, 09 Nov 2026 13:53:39 -0800 (PST)
Date: Mon,  9 Nov 2026 21:53:38 +0000
In-Reply-To: <sashiko-outbox-168676@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261012-pcie-hotplug-nullref-v1-1-6e21c2e89ea4@google.com> <sashiko-outbox-168676@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261109215339.1841223-1-rathodpriyank@google.com>
Subject: Re: [PATCH] PCI: pciehp: Fix NULL pointer dereference in pciehp_configure_device()
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Ricky Wu <ricky_wu@realtek.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 12, 2026 at 10:16:29PM +0000, sashiko-bot@kernel.org wrote:
> While this allows devices without Function 0 to be successfully hot-added,
> will it lead to spurious teardowns upon system resume?
...
> Could this spurious teardown issue be avoided by modifying
> pciehp_device_replaced() to handle missing Function 0 devices correctly?

Hi Bjorn, Lukas,

Gentle ping on this fix now that v7.4-rc1 is out (the patch still
applies cleanly to v7.4-rc1 and pci/next).

Regarding the bot's question above: pciehp assumes Function 0
(PCI_DEVFN(0, 0)) represents an occupied slot across all four of its
lookup sites -- the -EEXIST check at the top of
pciehp_configure_device(), pcie_init(), pciehp_device_replaced(), and
the DSN read at the end of pciehp_configure_device() (consistent with
PCIe r6.3 sec 7.9.3 requiring Multi-Function Devices implementing DSN to
expose it on Function 0).

I intentionally kept this patch scoped strictly to the missing NULL
check in pciehp_configure_device() -- the only unchecked pci_get_slot()
call in pciehp -- rather than mixing a broader change to pciehp's
pre-existing Function 0 behavior into a minimal NULL-dereference fix.

Please let me know which direction you prefer: taking this minimal NULL
check fix standalone as-is, and whether you think handling isolated
non-zero functions in pciehp_device_replaced() (and the other
PCI_DEVFN(0, 0) sites) is worth pursuing as a separate follow-up or best
left anchored to Function 0.

Thanks,
Priyank
