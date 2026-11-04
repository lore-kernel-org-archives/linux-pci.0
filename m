Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824975;
	b=mZy5R8kviNLOanSKZNkAz0J3WBOgrCGDdpnOWdKCd8ljQ4HM1q4cmSOlPne7Ze8RyFui
	 Pc0bVsHPbnRAIa6yPz0t1SierblWtovUJW5ZLsr8PDQBDJ9dSJLxpxtrka8v/CS6WAywM
	 sri9GmSQIbBPMUhuInTzXrJzW/Cr5l1CtMm/epJX2aeed7U24a5WEDGDidlVWs75xUdFP
	 uK+DKoPLtbqUxIz2kav5BfNgB6PShFBhM1t0tXCWGN/y4xwdZi8y3J/ii97LIl3gGtVoh
	 ZY+0zxkWknPOdTlWtCrTx9f5cPaEjie3vKtY7g6ZXyUIgyqeccOAfgXqi06cH+jGm7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824975;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
	bh=H00NPaBD9E2HwhcPqCvzRgftOVaLCyMep1/8Y4uz7Cc=;
	b=E2Onq5P7Ll/DTxj4iEPOBG3iLsiNfHOB2NLPOhLnHPVz9vQMH1Y7IRrYz9Ht0OCIH8wv
	 oth/gpAe4dB1O82+9Tetia9IZEC64t0LxkV2lQZGoADM8Qg4+TF0RYzqMZyeXXfDNtjKR
	 4XL1eRkaFewu1x3YEuU49DW+NskCKoVPuJ01v4Pd/Xs5+c0mcNT5VN7sislgjzA0meHeD
	 4wHjVDswONiX/F5BFYrPYJ3NwUXdPzXANuR1nA/FQrxJCvcM2e6IrqYk3ymn5CncZwGLY
	 tGaYtG7+EA3PEiyQgnLo0hgrs5tBy9cA28ZTQaSjoQ5JfKKBAWR5c6rFwvyMfEMjEEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="gRxr81L/";
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C51B606C44F;
	Wed,  4 Nov 2026 20:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C51B606C44F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=gRxr81L/
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jKcp231Rpz8vBv;
	Wed, 04 Nov 2026 21:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793824970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H00NPaBD9E2HwhcPqCvzRgftOVaLCyMep1/8Y4uz7Cc=;
	b=gRxr81L/7W1OMpmMQi8zxrHdkEkGVCX61P3Ffp57435m2H44samRlLlkAGhrfFfDSnFEpO
	dL9lF7mqeyKO/ieEaGzH6Skz9NSX4RYKO2E0ggDPLqm2YZ+scJffSucG/U3ghzv6qQXFdd
	83PmddmnFZkVXhvTvIMIGvtkuxjGSmjBg8ekTZ12crTJjMUUU8ndBSstsvLipA+JUjetac
	X0ADAgLZPXUz8P16hO4vtYMRGmMXl5OC3qjtAKmMb7XtCtKDdU110j3mOod2Gz5hXBXYjx
	Ng4hjeiZxchaD1ofnVeD9571xMOX0XCOmI5+1PcA4ISc8IG2O47yez4c8iLGWw==
From: Maurice Hieronymus <mhi@mailbox.org>
To: Lucas Costa <2000.costalucas@gmail.com>
Cc: Maurice Hieronymus <mhi@mailbox.org>,
	dakr@kernel.org,
	ojeda@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	lyude@redhat.com,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] samples: rust: add QEMU EDU sample driver
Date: Wed,  4 Nov 2026 21:42:38 +0100
Message-ID: <20261104204242.267185-1-mhi@mailbox.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030181540.102665-1-2000.costalucas@gmail.com>
References: <20261030181540.102665-1-2000.costalucas@gmail.com>
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
X-MBO-RS-ID: d0b702635722600cfdf
X-MBO-RS-META: snz8b99mbkbxckeqh4mkxj3pwpmwuyq1

Hi Lucas,

On Fri, Oct 30, 2026 at 03:15:39PM -0300, Lucas Costa wrote:
> Add a Rust PCI driver sample for QEMU's educational ("edu") device.

FYI, I have a series adding an EDU sample driver under review since June,
currently at v3:

https://lore.kernel.org/r/20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org

It also covers some of the infrastructure you add here (Completion
helpers, PCI vendor ID handling). v4 is in preparation.

Thanks,
Maurice
