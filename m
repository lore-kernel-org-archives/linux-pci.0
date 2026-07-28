Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D61384CD1
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220990; cv=pass; b=YjosxDJPD/i7Xv1tq7f37Ngzystw4AEpj7Rzhocsk9ll56J0Imlq5uFknc9Lg9jfzlhho7hMj0/DdTKiMASeztWkn8zevKBoCgK96mwloOh+ZtrKM5gpqLd9NKcCQIFGta4qAiWFW55/s2sj9ZMZvc11Dt4BRczb/Ytso2KX71s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220990; c=relaxed/simple;
	bh=Reu4n0MqzEPbxCflwFSnFAo6Yj/jcgdxmh4H8Xq9BWA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=h62AUkFj7AFDz/DljSlmGCdyKLip/h4NMxZWJw7F0/k2QSyeddkU4zKNFUjT4yH7Yd5EdbZccKxo1N5EwZHFlj0zJWy0Tu71xoADRq1glHGP2uVaQIEDb219qfMjK0QTCkg/2+5D6AJYBiVxw8VuYJFEOmOfYwni9J3c2NojfJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6MTyuEL; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6MTyuEL"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81f52945098so11897607b3.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 23:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785220988; cv=none;
        d=google.com; s=arc-20260327;
        b=VMBryx9MAt9TTxssQp7EuMci5K4lhvcjDzi5yEzwz7K7mlJ/yrVK85FHpLre1TcYj5
         vYaWbrvfs4x60Cl9qnXje4s15JnfJI9drKJydq3Z+T0UdFYMgc4MpRs2Et296hmJ4E8d
         grky+z0K4zS2KZeSZ7l8iXQGhZ7fkAvT/iDQYwhydK+9Nge2041W8rnpLzRDMMoLDyjO
         dfq14CD4sEKeBIAyz8nktlZ98AqyLIGKEIoWaCXCkUlRTMYpd/7rH54BmEfumVOKtYkp
         15fQGpWzcXnhk12DWCEcex7loR2ALy8VvLWqqJ4FwtwWiV8ZQlnOOoRtp/R45W3yzwvm
         ELqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Reu4n0MqzEPbxCflwFSnFAo6Yj/jcgdxmh4H8Xq9BWA=;
        fh=a6Cp4oyf37XCr+fN+x7VhN9URUO6Da72HB5HP8zHKjg=;
        b=jhPhmRSyCIWWOouO1mmyXgMaR0AXKldFxCdVDiCP91Pum3kSSunrKGhFzbtJC2ajew
         c7A34AMdGWFYkK+R2QbZXGcLnRJb1r0Y36ll4uR62kZ9kHS1Y4of3/Ths8KXIODOIMWL
         pHnjFjgmDiF4ifM9PF9Ml61xiBFVR3kznbBB5q4djEhlon0KqInRFIVN6+bV1M4lFn5K
         SJ3ArOnyOKdy6Vu9/nukEm0y1GJv9k0MgLHCv9bosNhSQGlP6aEHh7hvuvBqrtNZCjl/
         im9yGZO0kMLaF2DJjEjMjCMKORHWAfeiyEY9IIclfuG/dODMVPoibynBYTN8wlVu8dGk
         0xAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785220988; x=1785825788; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Reu4n0MqzEPbxCflwFSnFAo6Yj/jcgdxmh4H8Xq9BWA=;
        b=b6MTyuELCVrbyY6xscbMCpPVHbq8gFYNBkGNQOMZnC+V5Hseo8Yo+2vyK2+GUhlMSb
         7yIbk1S9tDbrmCYTfYVbyKJTLUc4+gJxQhfVzna8nxS1wrGlHAuF42YN3xXwWmcpAtql
         graNE1XMzbqcZDuroL60KHQ4iTwEJc9NEs4Oj9t/kEi6T2ArKnq/n2VVNH5weuKteddi
         CgLjA84+hUx5WgxbRXtwM2f5LirD3WIRQ1sgwaRjQ4oPwa9E2xacbl+GJsCBxHc6SPIw
         xMqDa4IwRTvg5Pnad+PF7ZMrqDJC1OVVm+h5zI2rsRUB6DRA7sPGsGa2sc0sgYlWJdB2
         x8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785220988; x=1785825788;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Reu4n0MqzEPbxCflwFSnFAo6Yj/jcgdxmh4H8Xq9BWA=;
        b=GbnUfcjm8bgw1Zddy1mQ99BGaCCGXcUhZCa9qQ/BxyMctW0t4YdXACxjCVcL1yn6sb
         JqI4uv3Rmj96Yq438lBaa3mWyKdlIUDbzHyXTjSF9gGjm2gV2eyminsFbuP7LJf0Tgg3
         YwamOXL/E0No0/PnnmMazX2l3h6XMNE8CoQn/W36gsN3ZkpwUxn5Iq5poPf3Ysnb2N8d
         38MDc9wm6puHRakiLYHremqQKHG5GSImogwgLjOjreGTVymUjqfzMy2fxEoZU4oqsT8h
         xoj5KtE6a+c3ezvH+VdK/1OScdvazbQEOzBSnvrkD0gwND2+oY6ppgc0geF+ruV8OhJ8
         EnWw==
X-Gm-Message-State: AOJu0Yz67RymLuMixzLL6TPd+zeXld88iWmPeq7rqH0hSr2paTuGBpUs
	GXGJtCNsgdgh+xfrLi+43Hk9uM7vcJlHGuJExjwpfG1t347bX54xRz2fVL3kvrn1fx7+dsK4iiH
	sUS/vt19jPQFlCujiH8zmVBJ00uw1KLTSOZU0Z4I=
X-Gm-Gg: AR+sD104bqqDwJg3TeJ0gdVjQONu8QjYkUMMbmVl0T4K9fd9xNe7uw57WIVgNfylvgg
	JfVW5AUiPw4bpBQ4EYWZJFNrbVaLCjXCGIAd1ult/o39ovMlW6iufsxFqxG1VeCcnB/Vk/IR247
	HbMestC+DMdo0HsICsvykmbemveUUsrwkYsLlooxwsw4VxurDXjcq2cJ60AkHBlL9lz3RyIXjlb
	1oqKpIgi11eIGioNgnkyqVRcVGcZzxrsCE7GChc8S8Zsfb7WazM1AS37tbgEVk7RJQ2kGWVGJSY
	QRG5lkwatji22M6fHNqUpJt2PnITTChHJxqgRHrgJKVY
X-Received: by 2002:a05:690c:a83:b0:81e:c95e:2be7 with SMTP id
 00721157ae682-81f991fc199mr5062167b3.3.1785220987830; Mon, 27 Jul 2026
 23:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: santhosh kumar <santhu.linux@gmail.com>
Date: Tue, 28 Jul 2026 12:12:56 +0530
X-Gm-Features: AUfX_mwJDiXzrMCM84GXjsk33oAwZPpCC8hm5Vy0F0F0hjLlu5f0CUfV_j_ZcNo
Message-ID: <CAKudn=rGv-xwAwTis8wpg31mxekyE4YH-E8CQoDTYovsPrENnQ@mail.gmail.com>
Subject: [RFC] PCI_IRQ_AFFINITY limits MSI-X allocation on 384 CPU / 1000+
 NVMe system
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	akpm@linux-foundation.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Observed:
- Linux 6.13
- 384 CPUs
- 1000+ NVMe devices


With PCI_IRQ_AFFINITY:
- some NVMe devices fail to obtain dedicated MSI-X vectors


Without PCI_IRQ_AFFINITY:
- all NVMe devices obtain 2 MSI-X vectors

Investigation suggests an interaction between:
- group_cpus_evenly()
- irq_create_affinity_masks()
- x86 vector allocation



Looking for feedback on whether affinity-constrained vector allocation
could explain this behavior.
