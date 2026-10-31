Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793473826;
	b=R9roJO9rk+1+3NZJDE19YwQxB24aOmRcegJvLClWsVtxvmyoHhoNBRg7+zKFTFCULj2E
	 FTpuPg+BCwIhNnu5NV/MefkTPe8ZRbOmiMDSJuRPyBFsfHgzF7NrdVnzG3ue2jbcc1VaM
	 YOD54yQnSb8kins8zsEYhwmupLR2NC9kme9YnWm7ONKFLKS3v87kF40SZobgpG8o89ArS
	 F8dPUa+MykA0fbJD3I1FYDCrM7/uIlolliIBDnYIaeEdxFe9uTTJVxbgXqrAp9fFQpWmp
	 zc3eUV2pduU5vLl1dGkNOuWmsHPoCToQB0HzJ4y7Fsq+Di+qmTty2EJJlCR1AZP98sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793473826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=P15p9Hb5w1tBvsdlJFg638wJNRLHIyW6DyqlyUCSHFc=;
	b=ahqlE1oOCjNmYpmGLxniVAfbxGqrgJwxiQe6GZia3h8v/wuPbSjPt9++cZ4y5+UjYgUy
	 6dPpGbOkRuDybOAUvT/YoAUmnpOjB9iNv2VPsknIiyHRrumjSpjwEgcelee2HEF7TpXkI
	 BjrZfYAhXK6Fvulxivv0Kq5VekraWHlENMrl/w/qY0h1G9Znu3JBnqimG8dWvEOAjooSP
	 YAgG+ywk64iEE0NbGeiXtz8cyBR3HSi1jnt6LtVnb61oUPqlsNFIh6E+ckfUU4fHDWEA+
	 dJDwWgjvGiswT3snqrrfT4X43eQ7u/iXlI0CH0NKxWFBVirH66Uky4CiGytRHLxb52g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nexthop.ai;
	spf=pass smtp.mailfrom=nexthop.ai;
	dkim=pass header.d=nexthop.ai header.i=@nexthop.ai header.a=rsa-sha256 header.s=google header.b=M0iRGKX4;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9829606A320
	for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2026 19:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9829606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nexthop.ai header.i=@nexthop.ai header.a=rsa-sha256 header.s=google header.b=M0iRGKX4
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so3123697eec.1
        for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2026 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1793473825; x=1794078625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P15p9Hb5w1tBvsdlJFg638wJNRLHIyW6DyqlyUCSHFc=;
        b=M0iRGKX4ZakyHPXgwlWKQuWrbvUmrEt1k4+8j+Da6Dso/Dh7GSCRhGjVKtDYwfzJrj
         2HEAllh00C24MUCD82TGUaZz4bWnjiMTRhAzuWXvWqNUwh9NIMyFAIxSoJmQ4tgmhnAF
         F245HULIR/4UBpfnm4XNgJVWo0HiMpt1bXAuHbkJDG9vLis8pelTxr1WpUiwasUmrW+0
         9tOkzQntOI0UA8bT96YYn1nh7WxQBJCWb1rCljfbu4Ofk4oPQ7yUkax5ncCroyqti4PR
         O+aX72UPS59IWB8w+y+J4RXBJLyCiSRq72tVighCAw7INgBmnyi41FWHKGgDOpB397rH
         f/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793473825; x=1794078625;
        h=content-transfer-encoding:mime-version:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P15p9Hb5w1tBvsdlJFg638wJNRLHIyW6DyqlyUCSHFc=;
        b=c6C8HcbhSY6iE2uCjiq0TPcs7lh8yXsmdUuP2+FqMZ8BuNtDKepS/9k1Cmqi3IY2ya
         vUOS+TJksvOttAALQqgjS/skrzAOu9099xsbNizzaAgyVYHXKOdzE/5Y8CoYAxpUf9zv
         ORe68a7ldP/WmJ567DNhYJe9aiKybhBHAUJJR545H7KZhcGujWH9Q2nCZAFfclV/XmSb
         P2BpuLUDH1DB55jksrl2Fx1ynREiwOlFFU80IP1WJ+DWtLMzscYPLLE2smvA2/wvGZ8E
         YmRFuUQCT54ZhYwyNY0LJjWc4MzFaI0/VTRwHpXl7d+RdR9dFo/zJmyfzIzNXV/0WqBM
         MTcw==
X-Forwarded-Encrypted: i=1; AKwUvBwuR5fdnAj5HdpNjqmsDzyTJZst9J3jaLT72YGz8qhOdayYvRoxRw17110WR3T3UFBwTOm/4BcI1W4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLk3fNqRz5yigk7bpdxmFAMItss0W4NIwagf6NVwmb+vpX4auHG
	+J5yOmb2H02tVgWr59mE+/umrZauk8sxvbA5jjnFeA+Xx5xECrgrkZ9t3M+5gFONsE8=
X-Gm-Gg: AYBFou281JzkOFjsnG8AJBGhKHqfYEWJ5fZKY30p73SvhLKUBWRejTXdh4wYZIeSPq0
	0dtvoizZI+k/TEB4FUKXq6wu/3NBrES6oiBW4VIyP99WB/1LfWQraSrvpxNY86QIsX4z/z0I8xR
	fxJ7JhfSquulOXdQIxZp2bzPUntmosQupeyqOhX1U2TedNj5LhcuRrAm9iC1WANBFnlxnuwl0c2
	FtvG8WYctDej9PQQITQMnL/dvgib8R69SoCM72VWq1iObNnn7bSD5LcysQh3QFe2d2bQe4gm7mz
	3PkuCi5edCVoVV5UEtgjW34v24hMaKBLmJNBl+gf7BU/Z0gzcpe832Xq6YVRZhhXLnFPLXBRzYS
	a/VJPMyhHPcm2z5B2i3Q8vlSRZMNQaRDIZprRbxR6iOz5o+NrA/dcX7RjGP73yVmsYt8tmm5yxX
	MxQ5nkHM3VlB0Gg0mP3hWEu5X2L073Mnl8fyiUySQp0fMS1zol2FTi/e7897tMX3GeOzeDQn7xi
	+303J2InvvVj8+lUzz1PDyh28JS9t5eFgKaeOt6Pt2wfwPujA/n71ioUS3or5hDNmV2k4WcLEcz
	qiLn141IY768hN6W6BbZU4mUk7UNoyM4Yn52TcUkg8dXAFGFtcs=
X-Received: by 2002:a05:701b:4515:20b0:166:5552:780a with SMTP id a92af1059eb24-1ac5b028b11mr7948547c88.8.1793473824427;
        Sat, 31 Oct 2026 12:10:24 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm17384804c88.23.2026.10.31.12.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 12:10:23 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 12:10:22 -0700
Message-Id: <DMJ9ERWOMF5G.3KVDIP2QE3A7J@nexthop.ai>
Cc: "Richard Cheng" <icheng@nvidia.com>, "Andrew Lunn" <andrew@lunn.ch>,
 "Rob Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Charles Keepax" <ckeepax@opensource.cirrus.com>,
 "Richard Fitzgerald" <rf@opensource.cirrus.com>, "David Rhodes"
 <david.rhodes@cirrus.com>, "Linus Walleij" <linusw@kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, "Daniel Scally"
 <djrscally@gmail.com>, "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>, "Bartosz Golaszewski"
 <brgl@kernel.org>, "Len Brown" <lenb@kernel.org>, "Davidlohr Bueso"
 <dave@stgolabs.net>, "Jonathan Cameron" <jic23@kernel.org>, "Dave Jiang"
 <dave.jiang@intel.com>, "Alison Schofield" <alison.schofield@intel.com>,
 "Vishal Verma" <vishal.l.verma@intel.com>, "Dan Williams"
 <djbw@kernel.org>, "Ira Weiny" <iweiny@kernel.org>, "Li Ming"
 <ming.li@zohomail.com>, "Lizhi Hou" <lizhi.hou@amd.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-sound@vger.kernel.org>,
 <patches@opensource.cirrus.com>, <linux-gpio@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Allan Nielsen"
 <allan.nielsen@microchip.com>, "Horatiu Vultur"
 <horatiu.vultur@microchip.com>, "Daniel Machon"
 <daniel.machon@microchip.com>, "Steen Hegelund"
 <steen.hegelund@microchip.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v13 00/10] lan966x pci device: Add support for SFPs, PCI
 part
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Herve Codina" <herve.codina@bootlin.com>
In-Reply-To: <20261012142826.159178-1-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
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

Hi Herve,

On Mon, Oct 12, 2026 at 04:28:14PM +0200, Herve Codina wrote:
> Patches 8 and 9 fix fw_devlink issues specific to PCI and the
> device-tree nodes created during enumeration.

We hit exactly this on x86 switch platforms with
CONFIG_PCI_DYNAMIC_OF_NODES. A driver applies a device-tree overlay
onto each Xilinx FPGA PCI endpoint and populates I2C controllers
(xiic), watchdogs and GPIO blocks. Their interrupts go through small
chained irqchips that are themselves fed by the FPGA's MSI vectors.

Without this series, fw_devlink drops every supplier link under the
synthesized PCI root bridge node ("Not linking ... might never become
dev"), so the irqchips end up with no consumers. Unbinding one of them
frees IRQ descriptors that the I2C controllers and the watchdog still
hold. We get a remove_proc_entry "removing non-empty directory 'irq/N'"
WARNING per IRQ, and the I2C controllers are dead until reboot.

With the series applied on v7.3, the device links are created (up to
32 consumers per irqchip), and unbinding an irqchip now unbinds its
consumers first. I tested on two platforms, with 2 and 3 FPGAs (4 and
7 irqchips). Repeated unload/reload of the irqchip driver was clean
every time, and everything probed again afterwards.

Tested-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Thanks,
Abdurrahman
