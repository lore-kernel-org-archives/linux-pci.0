Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C0F23EAA6
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779860; cv=none; b=TJs3uKDdTd2nJqGlPMl2uFYFEF2VDYkzWv4A+d73vuyNEu9AZqjQf4cThX7EdsvAEs/5dbxRtGU4E8EcbEI17gBbWfAjjBd/mgKMkBMwV1ZJAkcQo8JzCCntTq7SVca63UfbTnLquFKYSAfcocIyQcVm+GiDl/gtRNq1XZNHwMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779860; c=relaxed/simple;
	bh=NLxkTXXhb4lZfoSlYn/DCAEu+yY1Q8/J0EuZOVmvcHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SE2e/yfj76T+84wu6InSKJQ+pSsMBoc84avNIuTWpa3vcEJksxPibGaNR7si9YIultZuKxkVepqDcSLuByXTF/7d/LVleqRhjnNDXS4zAIIiKopjc55TwewanbyA2CC7gR5hlCDJJrxKZUIEpVStiS+yda8KeGT9yoTZXfPo8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfTCT9UU; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfTCT9UU"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9358dd7f79so1018965566b.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773779857; x=1774384657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIjTrdexuUjM5faw2dO4CK/6viq+maDR5VjRw+dpHc4=;
        b=OfTCT9UUOvhXsrSmTRlGDSmdPb0wFkSNNqGNQAif5VcyS/WtBDUafBR0Et2XPzGYmS
         FOxpBwPIPdTg8N9XnbsjPbLXQr5yLzp6CkKtLDh6l3X2nsSIMW9Ip3T+w2dtoS8CSJde
         GPgCPWfrpMYChyQeikbacKLTEkV1RdG3AkpeV5pRwRLcOhKibpgCqQD/v7yoOx2DohU8
         eqGY0JcsXfokg9qp6vJBuep6EIMbMIuQH6fQoos0bhsodymfoo9rAlVy1agUuUiBSxxV
         AFS8YkkMQEnbsUR7bPNN1APr09HfM1hZMpvTpwJemELmbBOtWvpzuaIY8bM0KoP4HOAH
         jCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773779857; x=1774384657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tIjTrdexuUjM5faw2dO4CK/6viq+maDR5VjRw+dpHc4=;
        b=gFHYbXLYu8r0Ks49qSoAFWSMXPrmou1rCyulxnxhS9e6uJKAo0QwKIYdboT3sRHoHK
         qFHpaGHTPbG9mejS3mNResdccFR+raIu1UQ2SLSj8dbPBamg4bSxjn4WLMYR3d1aR/NP
         IB0tNjDoHTTZxXwUj4Ik7hqY9iRb9Xf9KH3L7SGKGDdfd9ZgHFVNF9NzARGrn3Go4u9i
         c3IlWjRcE4qWmTjbYE6S58oiVms0IY3xuRLn2k/fLJzxCSws+3gsfe9pxiw7HNPO0rF1
         Ai7w0/m++mc79KD/CVCQPJCSSv3TJVSfi1XFGIem2YbhBn5KI3G6TBBZiIP/1GY7decq
         ZPDQ==
X-Gm-Message-State: AOJu0YwBMjc2K+isv/Gn427ZLVr2EX7OpB4dg5E3Bf95yi2Oi4ruEfzp
	ug+DiAQgDJM1WmT7MMyEP2d/RoJyj7hPMajv+cCKa7aDUlUXkBahd7xn
X-Gm-Gg: ATEYQzwwFw82waLxPowP8UXp96Dtm9SZtLqrciY18znYeqA/CouDb0lLyUEIf0NFfUl
	Hfwo1puRYJBpT+vm1Br2lJt05qrMJKnwcoGXOvUt8eI/M+qTc6UYc/dvB1GV+KBYXFWsueb5tQl
	WHId55ov/PGMR/FPll4dnQLJxw/m6IPjWuxVs7uq0jj0kcL8GckrjhEesmiDxjwE3I087zE7qYw
	vyeOZFcLcFhRDohunVdzBWq7RYonf6pmpxWaLGfRBkfR4lffKVzH+0oLcMsDx2kS2AubKKj/ylw
	CQTJR1Fjbb7aTevx0FbcY1f/xNEWeYTSlLuPDVrfETLVExU/etD88NywSAgxeaNT0dq8cgbtdiA
	yCXcu825n1i4B4UZl3cH45/0cA7cJwkUJLzZSvhCils/rDGviCJMMImfX9lzHtyvJ1OptfK/kkk
	f50m9BMSY9keM//55nOGSdgLuMpVy5cjr8PMMUKNKGuhyTIg==
X-Received: by 2002:a17:906:a892:b0:b8e:3d49:25db with SMTP id a640c23a62f3a-b97f4ab3864mr33723966b.54.1773779856598;
        Tue, 17 Mar 2026 13:37:36 -0700 (PDT)
Received: from foxbook (bfk214.neoplus.adsl.tpnet.pl. [83.28.48.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f1452214sm48534966b.27.2026.03.17.13.37.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Mar 2026 13:37:36 -0700 (PDT)
Date: Tue, 17 Mar 2026 21:37:32 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB controller broken by zero cacheline size in PCIe to PCI
 bridge
Message-ID: <20260317213732.68ccd2a8.michal.pecio@gmail.com>
In-Reply-To: <20260316200649.GA14565@bhelgaas>
References: <20260315015406.533684d1.michal.pecio@gmail.com>
	<20260316200649.GA14565@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 15:06:49 -0500, Bjorn Helgaas wrote:
> Is there an actual functional problem like data corruption, or is it
> purely a performance issue?

It's functional failure - some USB devices don't even enumerate,
storage quickly gets stuck and starts being reset by USB forever,
video camera loses enough data packets that no image shows, etc.

Curiously, Windows 10 64 has similar problems and same solution -
with some hassle I got the pciutils port to work. Windows doesn't
change cache line size on any device in this machine at all.

In my case it seems that CLS only needs to be set on the bridge. 
According to bridge datasheet, this value is used to decide when to
use Read, Memory Read Line, Memory Read Multiple and MWI commands.
But per PCI spec, behavior of some commands depends on cache line,
so maybe it should ideally be consistent across the bus.

> The Cache Line Size depends on the CPU, so maybe the good and bad
> machines have different CPUs?  Can you collect /proc/cpuinfo for each?
> 
> I don't think the Cache Line Size depends on the actual PCI devices,
> so the PCI core really should configure it for every bridge and device
> during enumeration, but I don't think it does.

Good and bad systems are both x86-64 with 64B cache line, and as you
said, it semes that Linux (and Windows) just use what the BIOS left.

I patched pci_setup_device() to print it. On bad system all devices
are zero except one out of two AHCI controllers. On good system most
are 64, though some are zero. My card gets 64. Changing it to zero
breaks the good system too.

The bad machine is a proprietary HP business PC with only PCIe slots.

> In your case, ehci_pci_reinit() might set it for the uPD72010x EHCI
> controller, and it looks like Cache Line Size is set to 64 bytes in
> both the good and bad systems.

It's odd that the kernel sets it here but trusts boot FW otherwise.
I wonder if there are any official rules for this in x86-land.

> The Cache Line Size configuration (or lack of it) is kind of a
> historical mess, and it only applies to conventional PCI, not PCIe,
> so I don't really know how to untangle it.

Not sure either. Setting proper CLS (if known) at boot would fix it.
Question is if it could break something else.

I also don't know if it's a common problem. Looks like it takes a
particular BIOS behavior, maybe a particular bridge, and a particular
device, because OHCI functions of the same NEC chip appear to work,
only EHCI is obviously broken.

Regards,
Michal
