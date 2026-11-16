Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827834;
	b=VonaCgcN+RZILR5368zmjhZZzY4IA2eUUcgw/NV5zFUP2mNln8AOi1pK7smql89Aesgg
	 BRa1eqWRrSB6XvOM+pI5ZszjgCwIYKozEPrg2jDLCmce7Ky4gTp33IJXYIzQyLQtJPM03
	 ceijb7l9nKZtiK1UhIhzAfcEEgH4k1qlsRw7AYAeUGHXBqx3//3OJ4PTVFXldU5bqJIHn
	 T6zW6CpAke5x4gQFmbj2Qjt13uMxNSQgoM8WIeyvTLDwtiV2Jb2Xs0MG5NYcZntBJCrtP
	 Ouldgl/sGhm09FjkubuJwRFqTsGhdqr8+qxeitv0Q4mYw4CpKhiI1/aCanJKceOSN/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ITw6ygw2AXNWGd7QRacWknaddhmjMVGAScdWdo2ralM=;
	b=jRo9YoBcIfGaKcmlCypaJsOVFSM8AKW9Vm7xbrOLy3A6ZM70jS+BbA35Y4fIj7SDz0TF
	 67erjbPr2DpjLD/bMD91U0tsWhiRtSdiY9+C0kKPdDXWObops18W3cj67u3d1TKQopygi
	 yckWCLvpGSSsF8ivu1/nS8/i3cGMy+2HZV9knrpzQ2s6v0uw3YE56FxRDtBDE/1NYLmi2
	 OE1GfYEq4BliPw+zDlWQin2J3yEQf+NoXHlHTUF76J0sm8CdS1sPVo0181r4zlyWdIw9g
	 u9Z+lSGP2lzfRkKfCCl4ecmc+KGp32Du5wLnEddtNyqg9b7PGlee7YaC89rdwaPHcHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVdhtEjQ;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B152606F1E4
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 11:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B152606F1E4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVdhtEjQ
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-498f5fa5103so1387491f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 03:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794827833; x=1795432633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ITw6ygw2AXNWGd7QRacWknaddhmjMVGAScdWdo2ralM=;
        b=rVdhtEjQT5FeVSjeb6g1KeCSlR5WAzfAQy36NgBy24G8Giox2QE9LPzzbt6UaGFg20
         dmoHkqnkTYm0HKTFVPgXMm50xQ7zxGmwscbQp9b2ezCn9mA436p3+7JIgS1yW8dgeXC9
         nfYhNw53+TIFpt6+SE4H+9FUJIhbR8zphpCjI1+mIXv8dvNLdbmO05X5YWYCAlkPK7eb
         f6iCEfx46EWybkK2aiebuDDLI6wMPFOvAPoZC07MvR6rqVRHexrTmKf50yOkAIscUDkB
         SZu3GAngH4UyKACxxK2RRwNXPcsz6NLOW7SZFKczhfldBlGdj5FDcsiVAzFHA7oS8Ygd
         nDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794827833; x=1795432633;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITw6ygw2AXNWGd7QRacWknaddhmjMVGAScdWdo2ralM=;
        b=wloJcfRQXnTGzG9PvcUvHdcRKODoL8jmm774uxE+HBUsK4X7/VRdvvkx8sYYLNpR2A
         ijIwRIqJOReAzgTobvSA1PcKknILQwZPP/uHwW7rKowOOls9oJ4TGA9clC8sW1ic7MGM
         OOI7FOKwknJ9J0JgQ8N7xiTMeD/SdrenWG9PYy5mxHcQ5bfZDp7pHa6DgSyM5xWsVYqz
         g/YJaU0RppqxlHcw8kDplHo6FXAjwyV8vO07/y1HDI6VG1JzNq9NDq0PeMmmUXnlgNFp
         af/t+9DYcVBNucnQWZCIzgBhOtBAF9fOz9wIwIo1h5SA5NhW4XtQDu+hNNmesHGR9/k6
         F3Aw==
X-Forwarded-Encrypted: i=1; AL+hErG0a2Bv1jQqpwripN8ng2IVZCM3qWPKjOfguni+C7U+ZfBqzaafbgeCAgzgHQUIX3u7YBIYTEO9dno=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Pq+vjS2i/9Fm9HyWRPx89OBjRhJtnSbC0/nrRxVoRYABc6/sk
	oViJQ7GEARN+013LQvQ7t4JZu0IIPjgG/bfjM0OTVfZ6VUV9DDOO93Fj
X-Gm-Gg: AZFdTZfg01rm8oJEuasjV21rXaxVytWuiZqAx/SAfrxhr89+mJbvrCoq9NhfS6BzxFS
	PMKDZPrLCjMjERl4VlVtWUgquetP3eSsDvuYjp87u3k0iMCmQ8GRv2UuEUUtJWehoRjguRkSidC
	GthUOPcbozq/Dy+F76F50xB6NifwWCNfrTgQCPdtc2/vcT6v/pQ3exOjOPbrPYPbTvTclzAHiCh
	Wh3wbKIw7GnT2ODDZwVca0usntWaxeKhKKR6+bCyOrsrY3pFEuQHXxuF5xx/F/r3LoRYxzqSABU
	NgQyaOHH6Th+Twqi4QQJJ6kQYWDG7kjgSE5MgorlvLJWzNJoBETOWeu2HhEc2aLexjF5K4gNI/+
	oGUTqdhedqx1nBoUgaBpRpXVtmOl7mV6gi/p9yBHupsepUf1EM0OOGTCb9Y1qUapL195vIZropC
	CGY06jNCF4Ja5dI3nD+/PQD/GFmOHnAUQYFjy9iwb6Zh0B2r2Y0Ecohzz2Gx/TeutVGJnt+9xld
	17rKf3P5idnQDzPuEoxlArNkHILv8RcjAZ+6sVBJYwJ5uf0mA2dVBs+L2orQHOumLnT9oPY9lT5
	tG9aTIAUmiyi7Z+rRTcXYkvX3zC9lg8qxitoxV0Ov+RHGKq6AZ+M7Bcuf/8HA8x58Pji5yY3IGm
	ID9GaNqR9ZdZr
X-Received: by 2002:a5d:6f07:0:b0:490:f98f:addc with SMTP id ffacd0b85a97d-49c71d48742mr21084457f8f.27.1794827832625;
        Mon, 16 Nov 2026 03:17:12 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c8d286480sm39476298f8f.7.2026.11.16.03.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:17:12 -0800 (PST)
Date: Mon, 16 Nov 2026 11:17:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Popov <pavel.e.popov@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, Arnd Bergmann
 <arnd@arndb.de>, Leon Romanovsky <leon@kernel.org>, Lukas Wunner
 <lukas@wunner.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Jim Chow
 <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>,
 Michael Kelley <mhklinux@outlook.com>, Nathan Ciobanu
 <nathan.d.ciobanu@linux.intel.com>, bcm-kernel-feedback-list@broadcom.com,
 virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server
 CPUs
Message-ID: <20261116111711.7b473feb@pumpkin>
In-Reply-To: <avqhIQ2krd1qgp6K@infradead.org>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
	<20261111234439.4098-4-pavel.e.popov@intel.com>
	<avqhIQ2krd1qgp6K@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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

On Sun, 15 Nov 2026 22:22:25 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Nov 11, 2026 at 04:44:39PM -0700, Pavel Popov wrote:
> >  #ifdef CONFIG_X86
> > +/* Intel Xeon CPUs whose host bridges support p2pdma */
> > +static const struct x86_cpu_id p2pdma_intel_cpu_ids[] = {  
> 
> Why is this in drivers/pci/ instead of behind a clean abstraction in
> arch code?
> 
> (and the fact that the CPU vendors still haven't managed to provide
> a firmware interface to expose the P2P capabilities is just insane)
> 

Isn't it a motherboard issue?
Since it depends on all the PCIe bridges on the motherboard.

IIRC P2P can also deadlock under load.
So it needs to be use with extreme care.

David
