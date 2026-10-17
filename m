Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204FF331EB2
	for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792242501; cv=none; b=jSBzATEdjbad8BqNY2ERsKH8/86RybgKwVjTl9MEWZfwp7snoqGRdb/Z3yBljZPV1dIG1TOopwL0Tj6QUiTefgCG+9s2I+tld3mGgvkYo4rLMqe+uxjLxcGiAF8VV8fCeqwSoVljGMP9FHTiX62MDHmZ88QoGHup50Tnxoe8bfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792242501; c=relaxed/simple;
	bh=Z/5JBeqwPxSZ0TpSsf5O+k1fvGG7B04vtfTOruv2JxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyE52d9aOGw02y8IN/efvm6xiKHyOIw8p1KGQykyaD4wf+IhmMPq60pJ/93JcD5XCk25fLL89C0R/kXJ0wUetz+a6v8sChiolYmpAjp+ZthpPFijDWu5yT8wuAoTvywfvSt4T6CF/v0oleheYmDr8J3Vjr5g/38uPJIFRjOCqZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXl2HU6b; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXl2HU6b"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-17089130deaso25522c88.2
        for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 06:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792242498; x=1792847298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/5JBeqwPxSZ0TpSsf5O+k1fvGG7B04vtfTOruv2JxA=;
        b=VXl2HU6bjknN1IMUfwiSPFCo4VVowwrSEmRotFX6qrdkgbsozOl3Sgewo2O/cYYsXg
         Pkc55EjKirp/4gxCfW7/bybcVFjy/TgoKYkAKf1yvgMlb2Ir8ikM85CcQInSJwJ52Ckw
         gHWUDuLm8EdyOQTVT6oM2XaqeKWqBK3Eusu+kBT0D9jWULFuVqhAvjf4AMFJCVjm3cJz
         9O6oO9PfUW8EK9WwFnQZHdvfq68nOFTWlL0Xx3ZRGePCm2uKpj/QEiu7qAn5mZvLV89A
         VqZ7tpokdg3y4NHKeIXL5h7ZQ+YTV6kBu4k6EAtGzUYxAFjXZxmERJea60rAaaKFh1LN
         WGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792242498; x=1792847298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/5JBeqwPxSZ0TpSsf5O+k1fvGG7B04vtfTOruv2JxA=;
        b=geAxNgBZJC/KAQss35fQJ1fi2G0u3/F3TV/D1MmirsWCk/HJzSccpWHZMD6XNvXz16
         I+wzP6dk22dOnUV57z2AcMdV5+THOhn0H6hzV9+kFSWDaYCYJ1fUsqQ00xQvtw0yvqqk
         QGbeyAczpa8kBX3PQgPD292l9GtfIZdxZUqwktaLfIKzULscoEjGrJgBP4jVk7OkZYOv
         4u6tMiWbiKjVqYixMnO//pDCGLcfNnBlQCoooj28xloEXyzGfE9inh6xwVGDPxNAyTDJ
         t/KSzTGPr9g8fvFSZVY277ytZfJsUBvYOTePL22gB2wBRSRcRNb0uPcmEwcvfSkhLOpb
         7e+w==
X-Forwarded-Encrypted: i=1; AKwUvBxd8pTO/MdN+dBVf05/iBMQ0HJ9R5PQVtseskoAN+fQWGtmocp2p3abTh3yvs6lysdEVwgFd49c0Lw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/V6OvBIU/blusjXZB5k6uozpr2EPp23Kub6YWW3c9iU12Irv6
	b4lReL84tfDGuAhu+pQG1J33EtYpmfEt+cyWeLbCT7Ul6v5w3eHOew0s
X-Gm-Gg: AYBFou3kbGKuUamgGd51+4uFK8TGmRiajMKYwecyS2EWRm9OHszEsvuskXSfHikDaWY
	bMDYf9H2AejCcT2z9Ro0TiKj1Or2uDPoe4cJLJLDgYbTDnEN6id+r2OfCJfsdWQ2rtOTrGoQfS/
	BlFdJQJWagKVBDGTThnuob7czTtXTdjwyrMBTx7TTbyA9QyTL/VIWNtjdcAf5dc3oTLquphJTn5
	sPctp//brxWGWC9O04JpfyU0YkekyFefiXqB4Wl/PlnzlBgfK337jNwrnDIpDQSU0S/pWTWsZuc
	ju0dFT5QD0+fHvDlUqc0a+NwSGlmhORBA90dBVyNnacvEc3e2mltNM5/IVCsKpGYdenHSeQhUEm
	++ieNH1uXUvwlEF3ammp1h5zSevYlohBKErEMzPzOSSzCWT3KZ3uRPwfQNinMJhhRNr7RE8KRmd
	ZDDSeguaZNxLxKtb6L8hxDToZyk5B+Wq7/IWeTcvwg8QbYkCyPiKh47x6MxHcO1CgBlq15YgO5w
	8iTvWnFm3laVBQiudpKeOgBMXOfwUJfRwsTNEXW28Q2nnwZP+iiCEEXjMrAdkY1OczK+tyHRq9t
	sqzG23q2BNAyrQGNtQ==
X-Received: by 2002:a05:7023:a5c:10b0:183:d275:cf76 with SMTP id a92af1059eb24-18511adbd46mr5910454c88.2.1792242497725;
        Sat, 17 Oct 2026 06:08:17 -0700 (PDT)
Received: from cachyos-aura ([45.112.151.53])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm18903260c88.16.2026.10.17.06.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 06:08:17 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	=?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Skip the suspend_noirq config save if runtime-suspended
Date: Sat, 17 Oct 2026 18:38:06 +0530
Message-ID: <20261017130806.305673-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016214123.GA1884818@bhelgaas>
References: <20261016214123.GA1884818@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 16, 2026 at 04:41:23PM -0500, Bjorn Helgaas wrote:
> pci_pm_freeze() doesn't call pci_save_state() itself, so I guess it's
> the combination of pci_pm_freeze() and pci_pm_freeze_noirq(), where if
> not runtime-suspended, pci_pm_freeze() clears dev->state_saved so
> pci_pm_freeze_noirq() will call pci_save_state()?

Yes, that's what I meant.

Thanks,
Navon
