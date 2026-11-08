Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794179195;
	b=pFafiKpjynowxQAse2hX/ZLmpfwcrE03IoLFrCpBA4eyQ4uQ7F4nFm6IUpJikZ8m4I8B
	 QLaRCHhyP069g/AgtGqRUKNsKZaMplB6OnbgCGOP9CPnMXGUU2FDOMGWQVPTI48Kv1fA9
	 j/EiabIbWvOoJnrGStisl8I8O/7vl3rrp8AMCm4xcJHsSPNbahXLhuVr4otTodzuvmoEI
	 A+5bzSjruEVmz9W0XBQDn/hf9P+uRAJHq44N/MMF1/mNaZcCcxMGM8ardV5l2Kk+wlLKi
	 vqVPAunH7X9xmvDPYI6QMt5WeAQvA7ZnZQUW0ObkjIHtprfxpyWO2uE0NJhF01zAIWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794179195;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=r+y8CQ+aNutDnqhoFEXjnp4bJTLJopAbpRetz6dHelc=;
	b=p0CuhSuj3J6C7+UbMRYmAefwU4wWw/dTzujVPY0c5hE3EwxfuEF6w7fy7v5G4kKgAWx9
	 0SbuFp8fdlF3qI0RKCVErP1RrAs3ydmHytB5v0N+0w9sLynmFSQeSJl4wGhxagXfGWeiY
	 3cgppjmPwI8WFKg9tOjorLCDScbrsRCzTqBVaSnLMnrjBrP2iNvhfcTsiOMI/nDrm3wQ6
	 pcZFR7XNNcJtOOr46/8IreePLddRU/nF3DQ5o+m49Sgw5A2A33rW0+N8rWEeU/f8haChd
	 pwUYFnB+UaD9LeJpGEqCPKIUcJM/ewhx9Sj37FwX5XgLD6mSVaQvXRi/45kQQ83kEiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=U+xl+M8D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501DB606A320;
	Sun,  8 Nov 2026 23:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 501DB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=U+xl+M8D
ARC-Seal: i=1; a=rsa-sha256; t=1794179162; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=U+XdoxztM7eUIcyKziLbVWP8OQzzFhPIlMFZhr4hdtPqgrf/9tt4ahY8NuVCXRZODMqUFgKNN1J74C2CY/Ebxl1rscXqEEgrxo/mfKlkj2NFt4gMcuHT5XFKdiPbpAlmV6i3ud6bwMeJic7KGRcIFc2d06qEOX4tKytxtgLvCaw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1794179162; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r+y8CQ+aNutDnqhoFEXjnp4bJTLJopAbpRetz6dHelc=; 
	b=WCJkCA7y3/E+eXiLYiRkmsp/A7i7i3XYL+UE0CwJzk3uuBGugLiStR7W/xqD1xJbDpvq8kF0fTXmjv6ipimcYbyHJpVuSOOiOcC8toZ8k9TZXV1bqgZRICpK6dalakePHnQqOyyzEPCnhTuxhCq2nnKOTZnC0owig3AE2hWDrKA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=U+xl+M8D5b6oVRqjnpVsocm0e+FbUMz3SZYXQ88EcUMnerg8h+e3ZrWFG0cxMLFG379cPDnWnUh+gz3gCoyy2/aXj0f9wC015pIgHjYOYnXCr2VXbm20LOzCV8SNSO6ipSFNsw+PmFIoUXA4FqQW9bV82AlJQxy5m5R2vJgMM8w=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=r+y8CQ+aNutDnqhoFEXjnp4bJTLJopAbpRetz6dHelc=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794179160553615.2293146265968;
	Mon, 9 Nov 2026 00:06:00 +0100 (CET)
Date: Mon, 09 Nov 2026 01:05:59 +0200
From: Igor Velkov <iav@iav.lv>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Enrique Hernández Bello <ehbello@gmail.com>, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com, robh@kernel.org, heiko@sntech.de, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH RFC 0/2] PCI: rockchip-host: Retry training and hot-reset a JMB585 on RK3399
Message-ID: <20261109-rockchip-pcie-deskew-result-1@iav.lv>
In-Reply-To: <6c9adabe-d632-471e-8fc1-aafe62115167@rock-chips.com>
References: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv> <20261106-rockchip-pcie-ltssm-trace-1@iav.lv> <6c9adabe-d632-471e-8fc1-aafe62115167@rock-chips.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Shawn,

Thanks. Deskew makes no difference. Helios64, x2, bind/unbind, variants
alternating every cycle, bad link bring-ups:

  defaults 6/104, auto deskew off + trim 0xf: 5/104
  defaults 6/104, magnitude off: 6/104

Your mail has the magnitude at 0xb, but TRM V1.3 part 2, 17.6.10.1 has
TX_TERMINATION_TRIM there and DESKEW_MAGNITUDE at 0xc, so I wrote 0xc.

DEBUG_DATA_OUT did show something. With Debug Mux Control (0x208) = 5,
share of samples with in_dllp0_data_valid set, 100 ms window after hot reset:

  good bring-ups 0.16% (99), bad bring-ups 51% (3, range 45-53)

The first training looks the same: 0.15% (97) against 47% (5). mgmt_dllp_error,
crc32_error and in_tlp_error stay 0 in all of them. With the mux at 4,
start_replay, replay timeout and dl_protocol_error stay 0 too.

So in a bad bring-up the RC receives a constant error-free stream of DLLPs.
I read that as the JMB585 repeating flow control init because it does not
get what the RC sends, but this bus does not show the DLLP type. It would put
the fault in the RC to JMB585 direction, on x2 only.

Is there an RC transmitter setting worth trying for that, such as swing or
de-emphasis? If not, I will stop looking for the cause here.

Igor
