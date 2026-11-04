Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813139;
	b=F8KbRPw0i95gStVLwgcPFcW56gFUVKYlnFXCGKQQxlKmuro0VJpAR+V5hO5W5tebPJpt
	 yNvrO+MfAX6TCVp3BsE0OsK7BDTvkHNwsUJBxnoiNWrKKc/ezjbUKl6HiVd/nZGzx3es3
	 oy1iRz6OYIgDIKTNVUeYSyAlr9fzSu7SsaYaxFWm7NAK8IxAdLT0e3gFvyW9mYPpRgdwp
	 gc7wXwcY/W7cbCC+LTNC/mSf9tvhyLQfI0XkVsqNXoRYcRwSI65U5uQ3DuY5qZ28hFSRk
	 sUJMl10pHx91brJgtTA+8gA52/gszghGzHPVvT60HrvSSyBVCCfbtcpSnyGEzHy6RdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813139;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Xenqm7tT8aY2/8jh0immIrLobh1PPDktvJtMt0frxlE=;
	b=V8M4sHvJ9xN5AMATEoBJ8/Rl8RCi0Xk/L2f8+jPe/aGO7KHKbPEKWjNuhmhM0pupeadk
	 Ft+ruZQ6eP/8ao9cs0ARKi5bvsY5JGSuChsqcLU64Ojj1fNJu2TNZOlsKBfh/vhvOFbjV
	 EnCV0Us5AqMlIxd+e4TRyisQgYmwqJ8Jr1VqHezwemhUnadZ45KoiZ1MmPMSmJ7UkihX6
	 ddof+KijxiI5QYKnSUAUjIf+cobZyT5S+IrVUM+WVSVF7aJoyC7l4+A3uFPHmuGXyX5XB
	 XmdW+EYbbbe49ejSSE9g2Fbv+wYocXvzzvGXuJVGisaGulbSaCrEgos2AI6h6RuKc2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uXUSWSDc;
	arc=none smtp.remote-ip=91.218.175.65
Received: from mta0.migadu.com (out-65.mta0.migadu.com [91.218.175.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3A606A330
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 17:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2F3A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uXUSWSDc
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Xenqm7tT8aY2/8jh0immIrLobh1PPDktvJtMt0frxlE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793813135; v=1; x=1794417935;
 b=uXUSWSDcK92X6GLIz+Jw8/CmM3fFrx5BxuYT63jVUmVZj9utLsJTCcBH7flqI+0vR1vD23BT
 htRa9gx2spS4Fn7iSpkFmg43hYbGFXMwkrPA2XwSe8yKjbYrdn1gydgu3TgKCzpUjrBmOjEOxGi
 SKdeRJqN7hQ7b6rVBHjjoTv8=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3b99aa60dbfaf8f0;
	Wed, 04 Nov 2026 17:25:35 +0000
X-Mizu-Trace-ID: 3b99aa60dbfaf8f0
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: shrihari.s@samsung.com
Cc: jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org,
	anisa.su887@gmail.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	arun.george@samsung.com,
	cpgs@samsung.com,
	dave@stgolabs.net,
	dongjoo.seo1@samsung.com,
	gost.dev@samsung.com,
	s.neeraj@samsung.com,
	vikash.k5@samsung.com,
	anisa.su@samsung.com,
	junjie.cao@linux.dev
Subject: Re: [PATCH qemu v1 3/8] hw/cxl: Wire UIO capability into HDM decoder and DVSEC registers
Date: Wed,  4 Nov 2026 11:25:24 -0600
Message-ID: <20261104172527.2172366-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1384010761.101793792283622.JavaMail.epsvc@epcpadp2new>
References: <20261104115242.2035807-1-shrihari.s@samsung.com> <1384010761.101793792283622.JavaMail.epsvc@epcpadp2new>
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

Hi Shrihari,

The switch/HB write mask opens UIG and UIW, but leaves ISP read-only.
CXL 3.2 section 8.2.4.20.7 makes ISP writable on a UIO-capable switch
or Host Bridge too.

With two UIO-enabled host bridges in a two-way CFMWS (4 KiB granularity),
the switch below the second HB advertises UIO, but writing decoder 0
Control with UIO=1, UIG=4, UIW=1 (two ways), ISP=1 reads back
0x00144000 rather than 0x01144000. Software cannot configure the second
position in the interleave set.

Could R_CXL_HDM_DECODER0_CTRL_ISP_MASK be included alongside UIG and UIW
in that switch/HB branch?

It may also be worth diagnosing a partially configured host bridge:
with x-uio=on and two RPs, one without SVC/flit, the HB reads 0x22382
but that RP reads 0x312. The HB UIO bit is defined to cover all its
root ports (8.2.4.20.1). A warning would make this inconsistent setup
easier to spot.

Many thanks,
Junjie
