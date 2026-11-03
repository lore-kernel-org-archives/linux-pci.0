Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=204.191.154.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735051;
	b=e0PNFG4wYjk8WKjAPcNSftKWrMYJE2UtAQqR0Kbtx69a5fHIVATE999AxwEOWbrcx2xA
	 Ir14PMclP0gAnQBjoni0LS7ipaEe9V8eZfElqoCa/SyRbqQ20KEfu5DDWxIgYBRrxm4ww
	 J6fFiOBk4ttFXw/tFUK+nTDRDpWjSW9j1fYJ2+K/tgm2eXl1ix05MF/FxDzHtuETEbukQ
	 An+U+oCGZRQaDUtmGIcHXQOZ/Usl5QsMKM1RLCik+65dbPCMegHN44bmJuspyhqSVdRm8
	 LLvyJ0VqCeWPjATT2hntTbj4KpgCjW35apoNHmOfuJ+9vcPovuRmX9DsCFugEsm51rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735051;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-SA-Exim-Connect-IP:
	 X-SA-Exim-Rcpt-To:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned;
	bh=S0XmN6tshnPoawF93CRRedHhxKwJV0Y18KTknk0yotg=;
	b=PqfWk3LCYIw+r1mZvPKRLvosDTmYN7n3mgFmOp5QlUlXfLlqjoPxx50YwaNIr6NhIPNd
	 aEn9YONvhbqfboSkgbRB2TAA4GgwVwpuU4pn/47eEFPZaNaxoyn+CqOf9USqfKj+LE2XY
	 QB3VRUaA5MR0KScZ2xyzgkp9EOLP8yeg4JOCmHhj9OhMz0hZzcAtU0EX2UQB4YSVXemdb
	 NAwYDBGBE5PnIZnNizhW6CRDi+NaEAX4330iq8DJ3Xqz4U+nQKTh9R4A6SBjab0aomUki
	 vdO6Y8UBO/uBPiwA7DBZ1aEd5vg9W4xcJ1tN1AwZ1Vtih1m0tHqaNMioe3ixXdiDaOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deltatee.com;
	spf=pass smtp.mailfrom=deltatee.com;
	dkim=pass header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=TZLCr9z+;
	arc=none smtp.remote-ip=204.191.154.188
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7C606A324;
	Tue,  3 Nov 2026 19:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0E7C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=TZLCr9z+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=S0XmN6tshnPoawF93CRRedHhxKwJV0Y18KTknk0yotg=; b=TZLCr9z+o6WE0S1r+mczSUC5UD
	1P6F9Wc0r5t92jVV04FGIj28GSQTN48TdN8FdVvIpKiMo3xB+DrZ0JiWdRSjDzXpBm5Xq8FtyP0I7
	6ATWX40xXi+PhDZHhGZp9BxDzfF7w/5DguE6cZdygOLOsFFdOtBKL17+ss6SCYeEtHXACBiBs34i7
	jep+3AW1WLbVLeRmAq2Gv+10/bNnjuKWOM31PEjjbW8Mb1s/sTCX3tyNy5nygWpHeJuRgNE70nYV2
	eD0TgBYUFK3S3oHcMaiQYrcYDHAA78L5+ImR28tTQhxlhppRqinbOiO2Zp29zNZ1rNekPRrj73h2Q
	7biJ3i9w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xOKQT-0000000955z-0bta;
	Tue, 03 Nov 2026 13:44:09 -0600
Message-ID: <f0475646-fe86-4f88-a3cc-984db14b4666@deltatee.com>
Date: Tue, 3 Nov 2026 12:44:05 -0700
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.li@nxp.com>,
 Kelvin Cao <kelvin.cao@microchip.com>
References: <20261103183410.GA1124818@bhelgaas>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20261103183410.GA1124818@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: helgaas@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, bhelgaas@google.com, Frank.li@nxp.com, kelvin.cao@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 0/2] More switchtec device IDs
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-11-03 11:34, Bjorn Helgaas wrote:
> Replaced v1 with these patches, thanks!

Thanks! Sorry again for the extra noise.

Logan
