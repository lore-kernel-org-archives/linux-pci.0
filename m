Received: from fr5000-r.dnsiaas.com (fr5000-r.dnsiaas.com [92.42.104.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2685B45DF60;
	Thu,  3 Sep 2026 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.42.104.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435277; cv=none; b=LhwVzrQb/f43MUURNGaTYSa4C0hlQtXN7+x7ObNG/PC5wrHCHFh/I9PmeYFkUcq5WbRT5dotpfZZ1+5zTRwaGLKZvqLp5SbvnvV5pyqnJIgbJ6mU3hgwTD3helbMYsrmBw9cZVThGgM9HEAzjRCKYWSoOtGrr5BXu1NCGXUtwj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435277; c=relaxed/simple;
	bh=InN4RO7cBF/yYPtCjFdsNRAwXtwow5lIx6hH7jqRO+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SC2iVQCNjOIWxVc9SHZCjM5almMlBmP68eZV8haD3zzl/m4+5/A5S/QL7bWheontl4Yy2Erz0OFFaZKY/AOSjkWfhYLvGrSxScwVgFN3anAD9HQr19qd5mmv1rYOGM3LQfryEurD87pHJXPLr0MgNk5LaiJ01jOFpxISBhxuifY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=superkali.me; spf=pass smtp.mailfrom=superkali.me; dkim=pass (2048-bit key) header.d=superkali.me header.i=@superkali.me header.b=im2nXcSp; arc=none smtp.client-ip=92.42.104.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=superkali.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superkali.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superkali.me header.i=@superkali.me header.b="im2nXcSp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=superkali.me; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=InN4RO7cBF/yYPtCjFdsNRAwXtwow5lIx6hH7jqRO+4=; b=im2nXcSpHiDtbXWHBMpWhEcFl7
	xAErob5qTuLaQriUbrGzr7BlY/GPCqFfA1k1Zns0ahS7FLJAZTCi7UeGuzGKOhg+E/Ipwe221pkVb
	coFeogkrejdHJwl0FUeU6cRvZblj3Lslqo/Ab0bLLVHfPXvCuXCZsFSPJKNV0g5ORwmwfA9dfMSfq
	H/yYwONPAEwHQ2EKe+7aFs/FAqaWQjTTmdKSykFntXck1VIfwg5RyUXCjxOy0w2cDSl4g9L+duymn
	akRoaeCIh/z+SDj4PfToZFfM9MtHMSiv2r/gPgS+hltShWvIqQ1GI0iF+BqEYCaGk9NqO9B6A5Ytu
	axFAjN9g==;
Received: from [81.57.40.39] (port=41902 helo=superkali.me)
	by fr5000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <hello@superkali.me>)
	id 1x25BI-0000000Dupd-04Hj;
	Thu, 03 Sep 2026 13:00:29 +0200
From: Daniele Briguglio <hello@superkali.me>
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Stephen Chen <stephen@radxa.com>,
	Junhao Xie <bigfoot@radxa.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 0/6] arm64: dts: qcom: Add support for Radxa Dragon Q8B
Date: Thu,  3 Sep 2026 13:00:24 +0200
Message-ID: <20260903110024.2385113-1-hello@superkali.me>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - fr5000-r.dnsiaas.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - superkali.me
X-Get-Message-Sender-Via: fr5000-r.dnsiaas.com: authenticated_id: hello@superkali.me
X-Authenticated-Sender: fr5000-r.dnsiaas.com: hello@superkali.me
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Tue, 01 Sep 2026 16:47:53 +0800, Xilin Wu wrote:
> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> Snapdragon 8cx Gen 3 (SC8280XP) platform.

Tested-by: Daniele Briguglio <hello@superkali.me>
