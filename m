Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813152;
	b=uD0S9xRzC0Pt0wQyUUFNNvLuuAxykerCdICt1Nrln+WP+2KMgVXnb0/+tlgu9439N0Hh
	 R2onSWds/fPfVCxskT+Ad2w+jw+nigIchc80EQ+o2yLWAeAW7K5ZoDH0St208ZtC8/vg1
	 1jcPRSnmgkdf+yAGRhWhe4ENnULhn1eBUI6OgGRkATKSxdgd+9GkS1KTXb3zm5c9MgS5Q
	 vxmygVheZHmHcFiPI9zvx7DgTU9wifPTZbpdPshlVn9oxXec9Dr0OuxySB8qslkIi3o4w
	 6dUyZ7xp9FXt7XYN8bahdNklPUVDSmMiyMumaK7JQtUtKCGYp/l9mqNt7imQ5rpu6rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813152;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bd5pazkQFKyYKEGSIrWiOc6GEPTqyZzq9paOrIDWKRk=;
	b=vATM0huEJX7q2va+uZ5vzKqu6ShearWBbsyFOiIhWZlkloaYdRRFQRp2WOeuCm0S9vhJ
	 CV9Z1FcI/gXIH5iCBL3WUL2o8j/82fTHJKuoesPV5kyh5Nu+vikgJh8zQKIdLsCM3kQUi
	 k+eQHp7pC6froX808cF6ul05UiVPJNZ+2PNQg8X/KdB/5neLZsbry2VEDXjBp5KQy7COH
	 OMVmCpFTtoHYW8j32IAr6pNaBI21CF/YCfx5bPBXOZBlOZbKhkS3XV8n5u6E2aMtrm/1G
	 T8zaucAqgUJyoEXW7kAjU9CcHwIiKWVu2pi3c09FLXc+IMMaIGV0LcLXHSY0C8CvsCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YMRpIUBf;
	arc=none smtp.remote-ip=91.218.175.86
Received: from mta0.migadu.com (out-86.mta0.migadu.com [91.218.175.86])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DD5606A329
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 17:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3DD5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YMRpIUBf
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bd5pazkQFKyYKEGSIrWiOc6GEPTqyZzq9paOrIDWKRk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793813150; v=1; x=1794417950;
 b=YMRpIUBfnwMjpobL1YZXYntr0uShvmm/gVsUQvDl8JotH/Fxvub4m/ceJEjRTI4vsdyZ9xl8
 xdlkVcv+NmXFVI6W2kUZnXWaOglWNSfvv/yRCEw1C2lJw1l+nKV5A+arzK/W/O/BPkB4ahzpXm1
 jS9oXOYhV431spqrq19YfZ7E=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b823a6d435641782;
	Wed, 04 Nov 2026 17:25:50 +0000
X-Mizu-Trace-ID: b823a6d435641782
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
Subject: Re: [PATCH qemu v1 7/8] hw/cxl: Wire SVC and Dev3 capabilities to CXL Type 3 device
Date: Wed,  4 Nov 2026 11:25:27 -0600
Message-ID: <20261104172527.2172366-4-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <331418503.141793792283935.JavaMail.epsvc@epcpadp2new>
References: <20261104115242.2035807-1-shrihari.s@samsung.com> <331418503.141793792283935.JavaMail.epsvc@epcpadp2new>
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

Tested Type-3 capability enumeration and UIO/SVC/flit dependency
combinations at cold boot and after system reset on q35, with the
full series on 3c99db7705c1.

Linux UIO discovery and a 1-way UIO region commit also passed with
Davidlohr's pcie-uio-rfc kernel [1]. For that kernel's UIO checks,
QEMU used hdm-db=on and CFMWS restrictions=0x2d; the guest kernel
enabled CONFIG_CXL_REGION_INVALIDATION_TEST to allow region setup
in the VM.

[1] https://github.com/davidlohr/linux/commit/4726547f45a612b2d953f5f4e13ab6fe34672c7c

Tested-by: Junjie Cao <junjie.cao@linux.dev>
