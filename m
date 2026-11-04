Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813149;
	b=gl4AHi0SGMN83rNkQ4NICvEJmqovGE8TOtbufY1fTNzBv8SE7ydAUjjG09AnOAWg3wSD
	 o/TB/KnIqRkNZqHoxyIKqvwIcUfOlgl+78jiIj8bZfyXkdWxtmlltJRAK2gXxdRYZVkb/
	 Vz+NdKRKWq13ILEDspwx1/3TfaxSj/LpdWNFOlQvOZDyB1UcVA3Dg/DWpuKvnrYSY51SK
	 0nixJh09WZhWt2ahqdekSwjKoXl9lRQ1uSCxeB3m4YVlGR3WyvMnBOkdPTy5DazyjHiXk
	 xDiSWxw39GBI7C0C9HiD0i+RTsC8uFGd2wFROP7CCAFBWvRnKm5Uk+MpW5Tt7+y7G/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813149;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MxR3c48AzklxPRyTJpjhZAtl2/Qg2f+G50G0qs7v1Wg=;
	b=E3iM3t+1zbh+DfiU9DW9iiFhctTWayaStvOndwhDV8dwKqLzLnjsI/Ay0ymMR7wqoo67
	 GQKvdq/rZCSa9uTWo6Qn47KkE0zv9v58BTbeqsxsuR6g5RBpot4wgz1f/UFg9jN5S4MNn
	 DxrlJ6tmfJz+R5OsyNAXLWdPnJibh+fIJze+fE1Xo3jw/P18ANCi9Zd85btj/Pf6cJoxl
	 xF57aiPeGK8mcu3YkLTb+mmyYvSUnVvzo1j0ECgt8g0fnbma9vmr4mc9CCfAsbj5wrYOY
	 q9O8GxLW1HXYKOwwBMG4aiBpPdddzHUZw8asmqJ0zHU2ZRTlM9CNjcTQM4jAhUa4PkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="wsGa/rsO";
	arc=none smtp.remote-ip=91.218.175.78
Received: from mta0.migadu.com (out-78.mta0.migadu.com [91.218.175.78])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DD606A329
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 17:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 499DD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wsGa/rsO
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MxR3c48AzklxPRyTJpjhZAtl2/Qg2f+G50G0qs7v1Wg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793813146; v=1; x=1794417946;
 b=wsGa/rsO78jClay5d3sxcOBtHBBN7fBmbamLWxfNz/pDSw19IMIKaInaViyCVPHdH/m+QTSI
 J/PJQpPdlQAnuBe2LYF+MOFeG3KwuGMoSHDvAnowVNyWhGn0u59PF0GtB2I5Hp5aolMBM92naHc
 DySQ7WwtxOYvO5Zj1JNblSYo=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9815f4b0805190e0;
	Wed, 04 Nov 2026 17:25:46 +0000
X-Mizu-Trace-ID: 9815f4b0805190e0
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
Subject: Re: [PATCH qemu v1 5/8] hw/pci: Wire SVC initialization into port realize functions
Date: Wed,  4 Nov 2026 11:25:26 -0600
Message-ID: <20261104172527.2172366-3-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <360067785.01793792402254.JavaMail.epsvc@epcpadp1new>
References: <20261104115242.2035807-1-shrihari.s@samsung.com> <360067785.01793792402254.JavaMail.epsvc@epcpadp1new>
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

Tested port capability enumeration and CXL RP/USP UIO gating on q35
at cold boot and after system reset, with the full series on
3c99db7705c1. The ioh3420,x-svc=on case reports an error instead of
aborting.

Also checked the CXL capability chains and USP HDM UIO advertisement
on aarch64 virt using qtest.

Tested-by: Junjie Cao <junjie.cao@linux.dev>
