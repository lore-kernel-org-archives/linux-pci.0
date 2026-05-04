Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B1278F4F
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777868050; cv=none; b=jVYVOBvvlihLGGq8bOlGkj1FuXJ2ldy3XvpNa0OCU5YTVqjLOQJDJmdRHcwEO4eamkYh/+a/Kpfmr1QKaBBqRKP+7Z1JT+kQyPR/UBTXxPx758wHTMJ+lBHECo96ER1Yy0xR1SaQlC2ZFVkxW83De7oX7P3yq7GZ19W3VZQMwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777868050; c=relaxed/simple;
	bh=cXf9bWSY5kzsjnDpmcM/IxoFY116iEGP1RQ+JvHmz90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+lq2l76XB+VZsZhOapuQZcnRlHZFFPIV65XkV25I0LR1zkZ0IIdIem+BVF/mtCm4jb8birOrs+BKAM7VLWdW32qDwSgarKy6fdLrvFBD6dLRFxjoZWv88XXQgUkxwlgyLq8TXh8EcZAERXQou+6BsJyakViThJqU4tR6t2ZdmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ouq84Xb3; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ouq84Xb3"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64e87a81639so2982357d50.0
        for <linux-pci@vger.kernel.org>; Sun, 03 May 2026 21:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777868048; x=1778472848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+hqqG9jQe3h+XNHUssoh+1SAkCF/JItpwxK1tygRUQ=;
        b=Ouq84Xb3u7tPjDwq1ne1OBUUAPNbq+OWjYyXLDt5DMJojGX1GgzDxUbFaxLTCTPeMU
         E9HdTtG2jjnd8N8w28iw4X7aTnmz0mVcR0khAsyvk38zgu3Xef4s0CL/YhK1/K89YfuA
         lDzZO4KlQdqY/9qMcAShF/ntGPfVv0WxCJS3p2XGRCvwrpcrdOlHZQ4DknfHvIep4+tr
         rh7NYeXXepjKKGmmbtV/4IKdJMgKX/BJF56PEGBMCfqzRHwmVEZ4Jh4r1E35iwyeyMug
         dGEd36dUWUEU+HLQSUiGUN3oFPDSCO24tFFGQ4bFtdi250C1z0dA+V0jx8vW4hHS0jZz
         nuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777868048; x=1778472848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T+hqqG9jQe3h+XNHUssoh+1SAkCF/JItpwxK1tygRUQ=;
        b=RvqHolMWH2wfxpyDrXzEhTx+8mgmvRfCCeOBY620+VyOkK3HGwJ/ZgYB8n/R3BLU7V
         qXbTINgVFTWb+vEMu41gCvNoMOIk6pk/h8iKXtzWYUAKqTvRxJQ5ZO7g/yjlriEwIYMP
         R29H2IWD5PgxHDAx4PWWkJU3dkhTr5uAeFgt0sHkppEfY2rzXw8TKj+64ZweCoTt6/sr
         iMby5NSAH0PN9LyRFU0r3LSgsGmeEGf7Nuiet8KvqUga4mgt2AGKEDu6Ulze4H2NyX8E
         0wLrmo/8vkXbEbcYt+WzTROH6ZClrfrRnZsblq+KVtSnHmc77a2yiNd46Sor0cuZP+DG
         jCfw==
X-Forwarded-Encrypted: i=1; AFNElJ8Mf5cj+TVjTzEVx6PyxZc/Ro69vTjjkl2+ksRDkGrt3LtlQY343JKbZGd3vDnj6vO2szpDp5YSNkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHXwbdLPsnQQH+6b48ECE/g7c6y1p2KFcy4hIahiwrkwa6CGQT
	8WzMPwAdx8czpME4xP23T4Cp4KEZxn7dUTHRo/z2rJfnkBYAV3LObN5i
X-Gm-Gg: AeBDietMwdDrdCjIBVyesSmhpNcOvyPkoOvGvMCJe4AX6ghB6bddZQ/duhXbbtzIKaK
	VKojn4STNmZ5CMCdSQQmHCdc/VcCViGN/pp5lKpJgq51aqwH8g+irA/IKvhS+J+1/jNQoGDtfna
	izZiqpwADcbv0TTu/afd+QW38hvEiLQN3gHlHc+zxuJpFLZp71u7hVIdmepLpSxB9CfwckevonX
	ciwypC0wvVtT82huM2LDAPfMgaMj+r8ESD5deVBzE09H13R7+gl4FCP89VyP2dzlsWXOgzSogoF
	NtHX3Dw7BhMFn3MnQbIAJORr5upSY5B6DjLX09OIlw2MXq/qNQKh7I64av3TuA7qQaIQVswWLIo
	5UdjACF7s7JwyWyYYUVh20WhaAZr7RFJxF0SWFdd9EdzI8/myxpHy7yrB//BDpdmmRwCXr2cMB9
	2y/7hv08cNCYBdkvw10kBJqxnPAam7aAA/zeua22kY/6OmFUlaeNAInmX9RhJffukeJSYd/C+K1
	HRjpGEWNA==
X-Received: by 2002:a05:690e:b41:b0:658:9bfb:602d with SMTP id 956f58d0204a3-65c3dae91aemr7518405d50.38.1777868048551;
        Sun, 03 May 2026 21:14:08 -0700 (PDT)
Received: from localhost (104-48-214-220.lightspeed.snantx.sbcglobal.net. [104.48.214.220])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e8b031dsm4907419d50.18.2026.05.03.21.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 21:14:08 -0700 (PDT)
From: Steev Klimaszewski <threeway@gmail.com>
To: krishna.chundru@oss.qualcomm.com
Cc: bhelgaas@google.com,
	bjorn.andersson@oss.qualcomm.com,
	jingoohan1@gmail.com,
	jonathanh@nvidia.com,
	kwilczynski@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	threeway@gmail.com,
	will@kernel.org
Subject: Re: PCI: qcom: Add D3cold support
Date: Sun,  3 May 2026 23:14:06 -0500
Message-ID: <20260504041407.289464-1-threeway@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <dd4dc11e-338a-4d13-9830-095a93187f4c@oss.qualcomm.com>
References: <dd4dc11e-338a-4d13-9830-095a93187f4c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, May 3, 2026 at 10:37 PM Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com> wrote:
>
> >
> > v4 of this patchset *boots* along with Mani's patchset, however, v5 does not,
> > and unfortunately, the machine does not seem to get to a point where I can even
> > get logs from it.  Do you know what I might be missing?  I have *not* attempted
> > to remove the nvme drive and boot off USB to test it.

> This series, will not have any impact on the boot, this series comes in to the
> picture only in case
> of suspend and resume. can you share your platform details and kernel you are
> booting with.

Oddly, it seems to, because if I simply go back to v4, the system boots.  I'm
using a 7.0 kernel on the Thinkpad X13s (SC8280XP).  The sources are at
https://github.com/steev/linux/tree/lenovo-x13s-linux-7.0.y (with the v5
applied).  PCIE_QCOM is built-in to the kernel.  Not sure what other information
is needed.

>
> - Krishna Chaitanya.
> >
> > -- steev

