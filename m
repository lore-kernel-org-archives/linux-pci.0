Received: from mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56273B774D
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355578; cv=none; b=mSX33peAYvRqkPdNCBIK5/+cTdKTiv0aUtRC9OiIRhAPqfcKpTSP7VvSV8lsvNemihzaN1pd5bfhywjIJGhn2V0EwEnvEtE5VB723QlyhmKBEJUH3XZ1Kd1cnCa3MQdaWnoarpTTcjQ+1FgnIg/SDTNYdON7GUW5R1/rcfCmg24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355578; c=relaxed/simple;
	bh=kEx5juAaGMpPT9V4dZHafbCN0tHJgI/vgPamOMCAtmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spraeNpU9dZzhqwwRFBjOKh1GsWaemNj97l3igyzNSCMsvv5KmuWwImZ8zW9fCZPNrDNU1HxeOVqq2rHGIMBnMFgeK10dTxBxhUlJHROSzmhyn7DNVC4NZDMndIGttTsfypvTvPBwJoy/y3/3BXDUNji+lVkm/cZVK3HI8rxlCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MBTIR3AC; arc=none smtp.client-ip=91.218.175.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MBTIR3AC"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kEx5juAaGMpPT9V4dZHafbCN0tHJgI/vgPamOMCAtmE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791355574; v=1; x=1791960374;
 b=MBTIR3ACrGkJhG+whhv2ItfawYa4gm4dfpw3/4hQr19rsN1iuyVMNiKGI9HL9TpywboaiATv
 pU1p6membxMvBtZSiiZAmNgMLRDIactZpbAbT0NQ0+KK2TRiW6QCapYhkDjYo+Jxd4INTd9bfcZ
 dXAU1SbRXtMaBZnmXqkdNZ8Y=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8b11206aac895c78;
	Wed, 07 Oct 2026 03:23:58 +0000
X-Mizu-Trace-ID: 8b11206aac895c78
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bcc04c71f5so4631e87.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 20:23:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzorYZqR8UZ/RJtjmp02vtqTQarI0KOEpQs2fvnOLH8QuS/Mt/x3t7nXYCT+RcMCALrN/nESIThyrM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgBi/RpgeKZ20Ms2ajW0rQC7nZymI9r2jE27zmDsKsRiXuVX3f
	3l2vVH1m3JyjgNuWalfDRVVl/52YMAGu6Clx4x8kmwtWxkoNoGG97Ci4z0IIqjoRcf/GQ37U+n2
	J+sCvaNQXlZbd0VlYoavM5C41nNuyj5ft1QBDKjWX
X-Received: by 2002:a05:6512:6289:b0:5ba:3602:4343 with SMTP id
 2adb3069b0e04-5bcca678614mr260864e87.16.1791343437807; Tue, 06 Oct 2026
 20:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923180749.3906547-1-fuad.tabba@linux.dev>
In-Reply-To: <20260923180749.3906547-1-fuad.tabba@linux.dev>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 7 Oct 2026 05:23:21 +0200
X-Gmail-Original-Message-ID: <CA+EHjTwPsMqjBgfqAWHxwp1Ujpk7b_BCu_u8WcOekfczFXAMHQ@mail.gmail.com>
X-Gm-Features: AclHuK_rKcz2_xdGb_jpyCXvstLTuyZHAt_pcvOQTxgAvV4JtvZe-_kS7YT5K2Q
Message-ID: <CA+EHjTwPsMqjBgfqAWHxwp1Ujpk7b_BCu_u8WcOekfczFXAMHQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: rcar-gen4: Fix device_node leak in rcar_gen4_pcie_host_msi_addr()
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Gentle ping on this fix.

Cheers,
/fuad
