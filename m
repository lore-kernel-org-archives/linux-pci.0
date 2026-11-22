Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323308;
	b=b8K1eBEM4gg7pE/hnVe4cgbvCg1RX+3Xq8wJhOgKFXxGnO2YsZLo+xUKmdvtw+G5DLPq
	 vDJeHXgFu4NM58HIja/px6RTeJ8cq91E/ZBJdajojtfYxVTrX4rCbtFPYS7ClSz8IDUHw
	 FBSq6ccCR3BrXlXKHtIFd4zI9TC9vU28TfaIms+H6PMUTSutS/5ZTP6ZwzUlBhLA5ReFg
	 2uIMJntFpsF7dh09Fo2Gxb7AW5bmkQ12gTBAAoaXdG6DthiY0+k0H8RQySHmPsBEKzzSD
	 U8g8qD8cuIOYOHWLir+7rukvJzTgxAFhDzxhOuJvf8BLzZQTgcHTOwRZiwzQ4+mdIXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=zo5hV3nq2vAzOrfwjLwLFQ7iNUuGgnQAdTEhOY7Nk04=;
	b=Qk+G0umH82WFBvrgmbDNmhavbWa+vJQHYhAoRqWZcvGZ8atUq0xTkNfjkDH13oukxMpt
	 zqmbB9EgPs8WdslutrDlyyf8r6cQOTMGypyzVjrfMw3Fk2GdpVl6a4qH/uOu4RrYMfaDf
	 Cx1j3mGaq1a3/jGz3tsTfV818c57lXHY9SFUXol+UVW4L8BMqLL0p5nG+C0nuOXc7kY9i
	 Wy81ZyL+rw7VMR7JET3DDBCV2an083TEYpLPGWItwYxEoh0YaRh4HBCuT6okjpmpDuty1
	 Qc/kDNHRIx5M8iJB6bqQSjsTNHn4t88n68DDqSziTrGEUaKSIziDQ9GdixHi9KMCuIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OTGCWyKF;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6D4606A320
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 04:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D6D4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OTGCWyKF
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so6623530eec.0
        for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 20:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795323307; x=1795928107; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zo5hV3nq2vAzOrfwjLwLFQ7iNUuGgnQAdTEhOY7Nk04=;
        b=OTGCWyKFZuWdrwICzH5qhVzKeOyJZX3Tp/aufBzZVXieQiqgUo5wteOFtFPdjtlKok
         WtDXfQ0iE+Qn9vpdtYbTMD4dgNj21yFzDR/XE/Qz8ECFPcEDtZIQBClS4VIw5O7kIxMq
         Fnk1zdSl3DtWUqMLXE0RhM3+OCObFnUUWdAtwOEsFK1vVZn8Niho68PM2rBjXId+Mx05
         RkdBhm+QMYkUNzC+dUElcjwUtvb9BNAE+QSNkWBbO4Pe5f76LBoSj9rztyGFHKQjT7EP
         mYR7TrfjKAosJwhZGqn4k8JwtrqibMZJuSrLILemOh0b+LCjInJC/lWJ7Mh7Xjc0BJaJ
         M17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795323307; x=1795928107;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zo5hV3nq2vAzOrfwjLwLFQ7iNUuGgnQAdTEhOY7Nk04=;
        b=UJFcMOvUnBb33tIDy2bZZdDUJQlazOdok6Kfaaxs90rXeXx9yupcHxjBnFejqTTpLW
         ovYzlhYSGqIEDY415+BhbkvC79moX+6z+3+Mg9z9lL0fjCK2YShJfvizRfJBWF4N3Jwk
         epdn8iowqKVhH7Tg1Ik0i24IrLbnwH0TprzRJfZP/uqp1knuI31aZnDFotQQ03SEYkSM
         kOo26K4a8InYdMTHQo2BzbbstGRnO2ZpJTUb48jZdfWOLyogYeyCUxaQqZU/kp5AlSJp
         r490iq6cv1oVc/kxW8z3gbedMCPoOxIBTvUN/0mxxS5XIoEu1+jQ6YKaIq890KJG8YOJ
         T7jA==
X-Forwarded-Encrypted: i=1; AL+hErHwIlDI9lEbVfwzSRMBK0hZwC5nsWSDjiPw3CcqZGsz8oDOHiQEswJugtXjQbeQ8lexlPUmljoB9VI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GsfsLAkc+03TqKLPyrCZ2CSiZ7RI9iV7OWtocT4jdAKlDbhss
	CoM96zEXViiJ/BppFUT6xdJ+vDLqyYafFJFklFCnV8TVXQVhROWjJGQT
X-Gm-Gg: AZFdTZcNcANVmf5Mvw4zFDR3Z4xN0RPgDlYjd1h32y3pF7PPXB68Y2ClgIDNmVKBLR4
	Be/pKChdMZT3wujDkp9sPFx1GaUb69T3jsgQPyW21OckuHZDWk2wYK8xuEq+EEsNa8tacSCHqHE
	9ISHpZWJBH2yckkwlv1VQ9KQghh1Hnj93qoHM5cBRN7wqTM4xpffgQImnlAPHNPS67/+pH+E4sC
	Z/g0hELHfF9ZWd76vkE+qm6vcppTLpypPSxzaKi2jX4mQkcaRY6340ckgbGIjaR8fB+dA5joNT/
	UD5FikuFh+WAK1DlJmPYt31QPKJn0/52OiXOLQVLGp9WMUdfz7oHP+POltG7mw0DhCJb/qiyH7+
	waXZ+IfAcui43bjFw16AoTJKps2kcNXAkmw6JEi3p4B4n8tGjmjxnfnJxQBPVztnw66NnoUFZZQ
	YpNj1viwEJp8HVWHGq+xOTrlxd0bkL+yjnw9ECX4QKmzsDmB1bSmawCnKZqRQiY3vx6TOgWavVi
	sh1U/cBIpfzTPZbJgt449I2mZaWnW0RH7aTElkAs/Cd5tPjKJ41q8goka6B//Ch1HC6Tg6A6AFV
	m/XJc5KktOOXL8eMxaivb2VRhzPBYG4hLUi9xxBKjVR3ORKTCRJ3RS9aqgkX6NAxZ9gXPKs=
X-Received: by 2002:a05:7300:d090:b0:386:8bd2:da2c with SMTP id 5a478bee46e88-3868bd2db9amr5813273eec.2.1795323307243;
        Sat, 21 Nov 2026 20:55:07 -0800 (PST)
Received: from localhost (61-245-143-184.3df58f.per.nbn.aussiebb.net. [61.245.143.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3866f299d0bsm15989477eec.19.2026.11.21.20.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2026 20:55:06 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Nov 2026 12:54:55 +0800
Message-Id: <DN1GZS7LQ7BN.34S0SPYOQLG1M@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-leds@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v28 0/4] rust: leds: Add led classdev abstractions
From: "Nick Dowsett" <nick42d@gmail.com>
To: "Markus Probst" <markus.probst@posteo.de>, "Lee Jones" <lee@kernel.org>,
 "Pavel Machek" <pavel@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Dave Ertman" <david.m.ertman@intel.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Ira Weiny" <iweiny@kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261113-rust_leds-v28-0-b8cf2f74fa57@posteo.de>
In-Reply-To: <20261113-rust_leds-v28-0-b8cf2f74fa57@posteo.de>

Hi Markus,

Thanks for these abstrations - I'm using `led::Normal` / `LedOps` in a
new Rust platform driver (`clevo-laptop`) for Clevo laptop keyboard
backlight, just submitted here:

https://lore.kernel.org/all/20261122-clevo-laptop-v1-0-881debf4d4b0@gmail.c=
om/

Verified on a Clevo/Metabox NL57AU laptop.

Tested-by: Nick Dowsett <nick42d@gmail.com>

Kind regards,
Nick
