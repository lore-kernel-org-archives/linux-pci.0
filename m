Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795395034;
	b=xJmqj3MZKEowg1qKsDqOSNSwDEsHtDFDqpn1CoBcdEvWeivj4mdGaYaUgOXhTHAD9RoW
	 XkiSvUR6MLXyWagUeJclKqaXNRKQRusOYBSDTNwaFZncAVM7Fl+lMoLodwv/ftREBSEv7
	 39bOJ3ftnF1tNYm0/Zn1/F6PSklSflJf66+KU8Gbx8D+ft98eruvxbkv59PhXajYKQ8Vu
	 p009yT4cbD8LKdhFNHa9LXp2MNN1RtiouLiZHwK9ZtsavuVW9t8gkau2KIhKMQJiT3P34
	 jRMIKDrNQ5Wwq78vDPT9cgNtwApPAVNdC+kFmKERs/LEOzT+yZn6pOGdjH0gB/wRH1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795395034;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=xLiURntbB8itC3uur3jIvo2tuZtCt2Zw/8T/g6JuAqk=;
	b=E5NRNuCDgQkc/MtmQE7Wtjvr0vvFT6KJvW6EVg1K0PYr1iVB2tvSH8cBwH/rj1xVPfQ8
	 S3q61/k2lra0BGNWkjr/9pXduzi8B/hq9TufLZgfrnXe2PiUhDkQYSjUpEZi6xLXSUIp0
	 oczCHizTZc+2VbX9JYS3DyCDen0wZmJb/hrovTDJTT07iqnARVpzX88z8e04UPwh6LxoL
	 6xVtBDtDooRVOir2wOIShrCkV1F7bPVpIWJWEEL2lCLmSJjXpriF6fCBokArZsQAZ88z7
	 9RaewcVVKbjFJnwD3KU0a4TieaZH3ZwCX7geyBv3q06Wuw2gO8XIfRlvD93+UpK+Jew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B5606A32E;
	Mon, 23 Nov 2026 00:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BEC1F000C6;
	Mon, 23 Nov 2026 00:50:29 +0000 (UTC)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] PCI: aspeed: Drop PROBE_PREFER_ASYNCHRONOUS to fix
 enumeration race
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, linux-aspeed@lists.ozlabs.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261109-aspeed-pcie-sync-probe-v1-1-71cc9e718623@aspeedtech.com>
References: <20261109-aspeed-pcie-sync-probe-v1-1-71cc9e718623@aspeedtech.com>
Date: Mon, 23 Nov 2026 01:50:25 +0100
Message-Id: <179539502571.13869.8848645925220262755.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=TUk7JwOeN0q99/GxC4Xg0mmPj1Aqg/FZ9HNmXrA4qOI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrA43Us9oJ7ZXIyO+S+kymUsQwcKiqhJZfXHGKd
 8M8PwVTvwCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawON1AAKCRBVnxHm/pHO
 9SfLB/9nn19XlJtmFtdKt3Vu7v/k9x9HL694oHFSO5sj5JJZvXuf4+QftYrPbGYdsoMmJa5cvpi
 gPRQ/NT+dAdYwWOKaZIsFNu3xu6hfI3wCCXMQIrHtsB/xhFF0kBvt9qmt3Xi+O0jPFqD74cstHq
 oYM1LQe7ZSemE7lvLDS+1ATDY6on8ABshw5qOO6iKJsSHImE6E22d2agTgfrOkGeeS+Gewm3ghT
 GNUriDPaWDHz+98MK4yiok9qWLavrRQYGgV8g8V/B6gv9C1sNRJoedhpUGFI2YhPISBU5jf+0XZ
 jiLlY/FCRJVgQdwJeRVrQNixqNvybgNxzEvq2voAEok6h9jo
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-09 19:57 +0800, Jacky Chou wrote:
> The ASPEED PCIe RC driver opts in to asynchronous probing via
> PROBE_PREFER_ASYNCHRONOUS. This allows the driver core to probe it
> on a kthread in parallel with other drivers instead of waiting for
> it to finish during the synchronous probe pass.
> 
> On boards where a PCIe endpoint driver is bound early (e.g. built
> into the kernel or probed from an initcall that runs before late_
> initcall), this races against the RC driver: the EP driver can start
> probing before the RC driver has finished enumerating the bus, so the
> EP device is not yet present and the EP driver fails to bind.
> 
> Remove PROBE_PREFER_ASYNCHRONOUS so the RC driver probes
> synchronously again, guaranteeing that bus enumeration completes
> before any downstream EP driver's probe() runs.
> 

I don't understand the problem here. EP drivers will get enumerated only during
bus scan, which depends on the RC driver's pci_host_probe() call.

Are you saying that the PCI devices are created before RC driver probe and
gettting enumerated? Not sure how that can happen.

- Mani

