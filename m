Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=204.191.154.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728681;
	b=3wvgbMyxz7tTmoLh0VHyENikgESm7cLmHXQ0ZCC5Vn60V88wfvEwhhAyPCj82IxKMYB7
	 L1FkOFMomz8GSg6U4Sy0bO5gJ+XLrOXHbWLDTa6FFwVCHr0PNQHznB70A4WSe9bw5iWdV
	 MFmhLiCs0N7DFm5k1Sbb/bwf/fsLjqUUsCPi9U0P8b5C9fH2jjZRm4xOVQP+CzDdsa286
	 bZF5C+DoQBeh0XR4Pqt1VRj2t7Z+fFBeskWrUGElDxzsqCeOCmNG6197ydg88OZkujTka
	 a7HEQesmXI5Og1jN1gFajbWrx68dyl0CEymWGxfNhCs7Io6keQvceT2Y1u0/KApr6Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728681;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-SA-Exim-Connect-IP:
	 X-SA-Exim-Rcpt-To:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned;
	bh=NfF522w3/7yXz0PgEukHvHBkf6t5LSES/u3PclVwy0Y=;
	b=IbPf20mc+YkjJrKzc0U1KXqSRBu7grKC3epuTyMny6379aCZTypzIBv7dMi1ILMeszWF
	 6Ya277TfCETt3UIHbkvFez+g6w7U081WBwSLr7ggN/2CZPqx7yDGQbv1Avsjsh1un5dlD
	 o1P1d1+rpuVTJRPckewhXMWwNWvzrjDJUmSEFF0VLA9/yz7LuVm2wrIo8MWY/FGqNEYSK
	 fmkHdRcsbihe6raq+1YMMeHhO2PmtXmQX+ZLQrsdzjH0zzXzrOdh+js5YFxW+7LCXHpR0
	 ua8j/ZfxOR83AVH+MPQFKJZpOVMI4b/R3DMCpqO13u1yQqkDoAbDO57KzkHSSEzIvJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deltatee.com;
	spf=pass smtp.mailfrom=deltatee.com;
	dkim=pass header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b="pRMraW/9";
	arc=none smtp.remote-ip=204.191.154.188
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8A606A324;
	Tue,  3 Nov 2026 17:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9A8A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=pRMraW/9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=NfF522w3/7yXz0PgEukHvHBkf6t5LSES/u3PclVwy0Y=; b=pRMraW/9W6LFSGjamrLHZFBNpg
	Aj3aRUPIcw9HuWYdaLZwYHxD1vPTJ4oXzFyLBnZcKIGiq1qkTeXi15tREHcj5jEsHKyYogKW7ZImY
	zGu0ubCyocqm0XlsXIvOTNQMenFIQ6cwQM/7igWcBUUba+7pFUr9FPYKwI0N72ltFaOcc1+tzU8Be
	T+9TNQDpl7WTMWJPf7Xid/J3r2ws37kGp8DV6UkEltjTuKzIR8qjWcjQbNkZnq28q/olaVeLgL4/O
	IXWJvQaw9REE4Y+4ENnH8QfqNZsMcIVrnrWAmzLKdSbzthbM+HVtZU1M54Bx13EYseEsUU3OrdgOv
	XtrBk3ng==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xOIlj-000000093PW-0vz2;
	Tue, 03 Nov 2026 11:58:00 -0600
Message-ID: <6845b467-b5e5-4442-9f7b-e2b0bbf3c612@deltatee.com>
Date: Tue, 3 Nov 2026 10:57:59 -0700
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
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>
References: <20261103175208.481170-1-logang@deltatee.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20261103175208.481170-1-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, bhelgaas@google.com, Frank.li@nxp.com, kelvin.cao@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 0/2] More switchtec device IDs
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Ooops -- sorry! I missed marking this series as v2. It fixes the issue
Sashiko pointed out on the first batch.

Logan
