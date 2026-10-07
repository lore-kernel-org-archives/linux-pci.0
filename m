Received: from mta0.migadu.com (out-81.mta0.migadu.com [91.218.175.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73623515EF
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355568; cv=none; b=Y3tOzf/z96b0BF1uJuOPRmHVkdl5K+uTPEyf7dpy7JhkTu6GVLY9nCfdPJJbLZppMtnKAYaVID5hPLFLuCYVYdiMk+docJ1PqPg16JZJW97ZxOCtCSL2Xe1+GGPRyO+KuZX3uNMXa2JpjjaZaqRV7KkJjp58O8ElkAU9TWZFbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355568; c=relaxed/simple;
	bh=XWhmaHnF0F5r9vJ5hEE64oYYoigOB38AGVvirhYDhug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIAp8pNuTygicNEG5ABpSGl20MSRpKn+5L7RfeOUHz8D4DlqYCtekYoUwWGiv/KdxhVGrX5VzAFkeJ4D0x6eMkxPjgQ99PPDLg90EA9G+EGWph1AhcVSJcikR2caYTN6D05bi9tQZcdCjqCQffCVR3L+vxVCBaMD5P31AfFB2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oi3RI7FV; arc=none smtp.client-ip=91.218.175.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oi3RI7FV"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XWhmaHnF0F5r9vJ5hEE64oYYoigOB38AGVvirhYDhug=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791355564; v=1; x=1791960364;
 b=oi3RI7FVJkZWDUap7jtEai8vsRQtW+KxNX2t8JUTVGXpm3A10L1sbrajGyMV2ufVx3BbzZXa
 MDn51/CVTbJwFK/c7gVoSWcGGyljhX6QL6l9beBuHIQQVf4iomP7jVuUA1F6dydUDOAEzG0QQxK
 a0x8xGQxiqM9QFT3e3PPwIzs=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bc316fb24836bdeb;
	Wed, 07 Oct 2026 03:23:49 +0000
X-Mizu-Trace-ID: bc316fb24836bdeb
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bcc04c71f5so4615e87.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 20:23:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx1drFuzN3igmFfP5QSq2lCGUl3nPxu4B/RAQ/KKNYuAAiUDEnNVDYnefpw7eDFhmntLXbt1WqJjlI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVwBDkot1NnkgTjqe+Xh3HwMVITbMGXGJ8d8ggN6mbv9CzJzN/
	QTk9ofQP6YCL9idnqj26YjwHoHtbbR3PnU0mVvBEGNtKLRY8+jemwBZaqAKtWLYUAVcN1bK74VJ
	qP4gJj+ZdipZEyOxLPoLMJfQNWR0Tey+zy6HDkDxZ
X-Received: by 2002:a05:6512:608c:b0:5b8:caec:cc77 with SMTP id
 2adb3069b0e04-5bcca64059fmr230164e87.7.1791343424648; Tue, 06 Oct 2026
 20:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923180703.3901185-1-fuad.tabba@linux.dev>
In-Reply-To: <20260923180703.3901185-1-fuad.tabba@linux.dev>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 7 Oct 2026 05:23:07 +0200
X-Gmail-Original-Message-ID: <CA+EHjTyUqTzkGErfkvXeUJOpKwmO6AOxwFtUB_-Gtqo756WOvA@mail.gmail.com>
X-Gm-Features: AclHuK-Cmy6M2r-yI92GOlGoRqwijpnzBsQ4122ICX5yj9Fnvw3oxKt091GVXUU
Message-ID: <CA+EHjTyUqTzkGErfkvXeUJOpKwmO6AOxwFtUB_-Gtqo756WOvA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: iproc: Use __free(device_node) in iproc_pcie_msi_enable()
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Gentle ping on this one.

Cheers,
/fuad
