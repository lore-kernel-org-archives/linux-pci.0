Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599431;
	b=qqePbP3Mp+xCp0f1qp1jpvX5BbtGTuB7eKGeK6mkQBIcCvFG0yi7eZ4Qu/iU8HYd5lQc
	 sFOVSLGpjJ6oNu9jCkymbuHVbiW4XDN9apDpEGvDZo6zxD/YyUcUSTZuQUWEv8SBoOg1K
	 xMtlZx6+FTR952AeqznADWLtawgnSAa7SYG5QmIlC+tetw/TpxcLK5xTcOyLWEvQqLMpL
	 dV6K2tIJadmwlIYf9STURVIobnqliJRPOa/HlGObcc/yUsM+dbkPNWOIaF5bkVyhRxknl
	 YiOG6lyi+c2zdvYAu9ue6hyVX3Z+9gAgWyAOMN/GwxsLUWcAVvvvlLjMmEDHB0b6jtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=a2cHGLKa4ChBnuzA4CAjFivDrSBNfot35o4OmhNmk7I=;
	b=obaUW5DP3XNmryC7ZVVRg31NZ0M/O/PcIQ0HhfSI010HnKfhmMJPl+HJFRiR8TIOuYyM
	 UK+zKUniBt11dZ/jFM/0bt2ssInFhtYTEY1nT2/UDB6ZEk9D/9ImoBlFFaF782BZFe3WM
	 ZRjnyj5EUOkzzfQXmPFh7U+0ZkNC/00PZy5t+qlLHLmr4rgTX74d6G51rD6FjS+ZMrSR+
	 pMO01sYkV7pTZNihY+fA0+KaFgujqATSpa3AboSpJn1nbUcSWarShNJG3oa0TFa72mpV8
	 h8z1HOD12oXH7ECioNke6qbdbrTeCGdZ/sVVzrU4pEE5uG4u2z8CJ2Vzv6RKO3LOdWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=XJxNNhwt;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414D606A327
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 19:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8414D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=XJxNNhwt
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso729342a91.3
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 11:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794599430; x=1795204230; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a2cHGLKa4ChBnuzA4CAjFivDrSBNfot35o4OmhNmk7I=;
        b=XJxNNhwtP8bo7X/MfuL+1ly6k1wUKRjBUk/gv564/quCH/tLGcASLoIlXSZL56/mq1
         zB+VsAIT5RaCLIzbdjuGIQYE2DOO51CLoQKlalLNVK9Vht2KF0TQfC+6kuQl7uXOB3Kv
         uZfcpMYYRKkq/xR5LQwghiOY6EaW/Lb+TSNrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599430; x=1795204230;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a2cHGLKa4ChBnuzA4CAjFivDrSBNfot35o4OmhNmk7I=;
        b=zk1Q91Z5R3ywWL43IHXTaGq20vYEVvfiVWweuD/Pv2XroK3i+9ZqoE5mrOUKbCA/zI
         jGHPX07ZnNyPvIaq8HIearTIMe/o6L1tD9r/C8TAPQWSQADo0Nu/a6Ihp4oB0Lb7kOmD
         +4H2+Tg0HNaQEAq5Lwz3FtUeEH2eEwqBLxuNOED4mXKbknff3Fqf61TEIevtlyCHlPyT
         q/GK4BQ1TQewfc0wZI/n+cx8OFVEMfLAtQ0V/tOl+Fr+SYCWOosC/ymz1d3oW/xdc7sy
         z2TlQ3aZwuDIWjUOJh+/zwaXaK8KhlZCSLKkI4vheI6GwmJguXHxjAutWAWPCzqtDNKR
         eZKg==
X-Forwarded-Encrypted: i=1; AL+hErFprrZAipdu94FiYSSPqcb33QaOsi5nLI3/QuV5VdcDdJ0o0QgCUDwEa/NoztLw4UYg2DeBRqQgKl0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iqD5TI4DJXdgp7D9gVfXQUA2HOdc5AlNq26yaj4o4QBQr9oZ0
	P18ebYn4d3RgTF5XzqFW0JX14D7WTbb96X0kyUAgVkvfx2BGjR/0MnOlBdasfN22vnU=
X-Gm-Gg: AYBFou0WTv6Wj8+l35mxoJEJkDYpbEh9x4baGkniFrHxd9CPqkwkV3b/oqGc1n9GHmL
	g5xKek/K7OVLIk8aT0uBB1aVjF+K2EzRaLMaxXZfmKHy5GI9nmaQZjhZufHneZLPwZ7A3vyRgYl
	NqYD72PIh1vLpYE12wmcyioOPHcQG4L6JpqyKa4ALPHp9Y3xA35+L2IS7L27uDCUxXZmfr9BAAq
	UjaT+H7exQbnWrb0w3SFnlEv4yflR3z0QPol2TnnjzU0nD0ihtv4XgLVsjq8fIsU4yyp3FcdBoo
	QCtNTw54kGTxgzYfu3MHbNsF9cSdq29n/FQNRBveyQFStR7Te3BOKoVcF+RZuYyfV9rGk1+c7fZ
	XWNwZ2f9nhXDyy0VqIrhtw2oSMbsD4QAcpmAg+5Oaaq4xTZeXiOnNbxBUf4QTUTWHPA4Yr3cDYS
	V2UpmcnJ4UnggixgvOP0PnKexq253PLz8ztK0kDP3B1PyIvv0pde5d5gx8REpf4dKDPW2GM2V7Q
	0Gtx5DyIw5c06ysaXsF98p6FmrMnE/e8znV/Q+Gp21S5PP6ufjtoTaDhRXYzvQVsykU6A9akaDc
	GzFfLcVLiI7Qv0WGLrzbgRvVCF45YDsHZw+5+Bsu8i/Kyh8zNnCQQJlCCeLwPMdLqHghIKIK8EG
	WrHUdBZAhCrPeEMI8qV7z0gcqeZ7rDnjd5ZK7GN+66r3XKoKOINPOHjfrWE458q7mFgC5xbHn+l
	5TeuOQnkCuSyjcLOzwdNU/vKf/GE+WlLkJE/clKYyxqGTjt7LjQGmZa+uUSQxM
X-Received: by 2002:a17:90b:134f:b0:3ac:b048:fa13 with SMTP id 98e67ed59e1d1-3b1b0cf9ad5mr3440579a91.67.1794599429822;
        Fri, 13 Nov 2026 11:50:29 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18adce4sm1656569a12.23.2026.11.13.11.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:50:28 -0800 (PST)
Date: Fri, 13 Nov 2026 11:50:23 -0800
From: Chris Down <chris@chrisdown.name>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [PATCH] PCI: liveupdate: Factor out pci_dev_ser allocation and release
In-Reply-To: <20261109174009.735309-1-dmatlack@google.com>
References: <20261109174009.735309-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261113115023.0690d833fdabaa41@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi David,

Thanks for following up on this! I've tested that this works well.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
