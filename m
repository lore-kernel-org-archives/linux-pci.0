Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180183;
	b=1bwAXnhJCM6qMfCB2cxgMwd1ptViPeair+Q4gVqLZVo5KLXFrT4EIbSZ2EzdzdrZYuti
	 4Z2+kZSEaKasebGmSVR0fWEHI5HwDzcRVyYEUYdYK99w47Ai3Z3j/n2lUORIpBFzYBtiS
	 di3HP5o8qiTQpXwjxD5Rmz1Stcpsr+Vkumkp8DR+l+5AfMs70+D1igGsoPi2oWAEvHb2v
	 XZVwLx/dx9tQ2n+O34+PbzZim+cNTCORLXBmh04dn+HxtxExkaMCis2kE/WzQGYzktSt1
	 l9IJumCD8fnaPEFmEvgRD8bZZgVzVv3atL03ZMZywJ5Mh7cOS2nepQsRkLZwqkjgoFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RasCjunpCh/NnC9QmLv8I/gSUP58pKx7xFWImX02RhM=;
	b=zd+JqUVP2WJ3TpB030aw3zw94IDlX90MxZXbZpnY7jzrXgmzov0t+E2UrwOpDVO867vz
	 Hbz+a2cqq8cO5WeJVtXEg3WkHPsSSflCFuMzWWGLGhmfDux5RMmf6N4S1nCteZTw5EZIC
	 wy0ajcDM8qnn6FwLe8gxOIw0WT1jmTQCFq/6V1NWHRbO0BLhl/GXkwtAiubAKTLQ8ui9N
	 /Zy4kPr0PfJuRwWLz5tdA8WxQA4UCyjnJKXUc0rDsENgPZUMVLLSAsG7ok4KGqIm2CxWz
	 1Lp2j1eCjwEeUjRwyS3/xarOEn/8girXdv/9GKWq5jiCPUzoJC9T7Lfh28Whj0auZnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IO5fdKi4;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A3F606A320
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 09:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99A3F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IO5fdKi4
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so8899975e9.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 02:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180181; x=1793784981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RasCjunpCh/NnC9QmLv8I/gSUP58pKx7xFWImX02RhM=;
        b=IO5fdKi4z0OLJU7M88/lVVb6oujx+gY8duIyBx8erfI51FuYBuaXd1yPV1ZBI7NoOg
         cFY0Q9LmITOxTsPeS93gOoaQMCziY4PA+/tncE48IFF9LRHTnwxXwMQSi1gc07DrcAbi
         +US+GjuAJFUTxb7VS9qX69A4UheQ8Tgm1cVq+w8nMetORtjcvnGD62cFm6SRwrBbCKL1
         g9UzJ8T5x2+Vtp4TIh5aYPMoUosdmIv3WRAbx8W3euHH7pulvB1/YJ6i8Awr7pYR/oHe
         c4lRhn/5iZk5jZALIdNkyQ6p7gvoh5Qy/qH+OqYHc3QhTOdURJfLl3LX214CvBTHizv1
         US5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180181; x=1793784981;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RasCjunpCh/NnC9QmLv8I/gSUP58pKx7xFWImX02RhM=;
        b=R8KKe5h+lJfk4i+Id6taTeoflS2P5PHyocvgjEuxrmxk26BtJAIZQvf1n82Ui3VREh
         wQ5DfEaKWcLD/ff9SnbGXHB9l3UiFB54NK91/tuxP4wkhD7rggmtf1h7wWDdrSK3M8zC
         BiptxYXcAn/0URsiFagT6zdiffT86i95zYH9fYmXLKrXi66MNT6CSNk+PdBeudcUkHbq
         H89XUNoiUX0+GGtuBJGOJkl6JwZFhvZTIB84IXpu35Faa/fGHwyDbo1YyLHY66FvHLEn
         MEabvYYCzmLIC8pvfCjiY/P+16S1QdQ8UJ9N3wlDJ7sRNkrycN26F7KLuc9CPccJMY6C
         bL4g==
X-Forwarded-Encrypted: i=1; AKwUvBx6TpmCUnWfSU7KKzQsT6FiYMZGQpwyQ//BJv65AiWNqEP/rDgLZXszNZQ1w5K7n5wa/UmO3uNvE6E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaIgniIysGpaYhv80p57zRaaMBSqNW4U51lKqX9Ec4yE+3gY4m
	uRyh4O2FyZO77rrHIL6UXB4Qq5bCwTbKuubRcfXS5JsGHy3fWBXi1koH
X-Gm-Gg: AYBFou0ia1iKhxOZbcFaMKcYFR2A3mZdtUm5qzxSCdUkzKJ4jD5Ye+aZBJRqf6enAKx
	cjbXP55yzvArn8HMlxmUOwJxmMJs5bWaAuqO6zRuyh7UxNMuD/Q1fu1dqbJpRm1PsKFkDyhbQsJ
	2ocb2uRqV+10Vfh1qoSJQ3aOtB7LenwYC4PcOw7d22vOKcNAC0MX0i16s/xoY73QPdn0wtc+Nn0
	maOy69yfMwWB8nR2SDeJwgrEbo2kVrkcDm2qHILxmKYQBWDj8dTf0Eh6QH3m3SxgRex3/zis6ne
	pZ5NXrp7eTMQ74Zd/hjIHtP9mQO73cl7HkhBMLpt3Tk5OtLqUAkHI5vDQ7mWkkaM9jnT6UZ7dDR
	xBUfjC9ThC5kgUzMnJhSE5R50gyfex5mlit4URhoTAwmtWQsJvELNmmtcmEeG6NmJ2rmNVLshFD
	fY3lxAfFbgFh/LJUf8+jCmRGJTUO0rEtVcgNShDETAlmIX84QfNcJLBHjYL3bYHvVZ0w0pgHJ8e
	MlMkIWnmm2c82PMxeaOo9cQn8n4mF+fROKhq6dl+2zZgiaQN8h8YrVFrTnWbX4hnZEFvk+sWd2C
	V7xiMGfOsKIcrOzjMQ2SjFKo75Bn3sJamfbLcQ==
X-Received: by 2002:a05:600c:609b:b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4a965ec941cmr33454985e9.7.1793180180835;
        Wed, 28 Oct 2026 02:36:20 -0700 (PDT)
Received: from foxbook (bgu81.neoplus.adsl.tpnet.pl. [83.28.84.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a9ead8aa0fsm5886335e9.4.2026.10.28.02.36.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Oct 2026 02:36:20 -0700 (PDT)
Date: Wed, 28 Oct 2026 10:36:16 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: wenxiong@linux.ibm.com, mathias.nyman@intel.com, Bjorn Helgaas
 <bhelgaas@google.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, wenxiong@us.ibm.com,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH V3] xhci: Reset TI USB controller on xhci shutdown
Message-ID: <20261028103616.29110069.michal.pecio@gmail.com>
In-Reply-To: <20261021160608.8229-1-wenxiong@linux.ibm.com>
References: <20261021160608.8229-1-wenxiong@linux.ibm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 12:06:08 -0400, wenxiong@linux.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.ibm.com>
> 
> Fixes kexec boot. Without a hard reset, TI pci usb chips will fail to
> initialize in a kexec booted kernel.
> 
> Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>

[ Adding linux-pci and Bjorn Helgaas ]

I tried to make this code a bit more "proper", by moving the
pci_reset_function_locked() call to xhci-pci.c from xhci.c.

I found that when I actually run this, I get a warning from PCI:

  unlocked secondary bus reset via: __pci_reset_function_locked

Bjorn, any tips what would be a proper way to whack a malfunctioning
PCI device with a heavy hammer to ensure it will work after kexec?
Seems we have pci_reset_function(), which locks the parent bridge for
us, but it also preserves some "state". Do we want that?

I'm also starting to wonder if we shouldn't do this reset after kexec,
to cover for kdump. Or maybe both, because shutdown() is supposed to
quiesce the chip and keep it from doing DMA, and we have no idea what
such chip is doing (if anything) when it refuses to halt.

Thanks,
Michal

> [...]
> +	/*
> +	 * TI xHCI controllers fail to initialize in a kexec
> +	 * kernel without a PCI function reset
> +	 */
> +	if (err && (xhci->quirks & XHCI_RESET_ON_SHUTDOWN))
> +		pci_reset_function_locked(to_pci_dev(hcd->self.sysdev));
> [...]
