Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010F03D410E;
	Tue, 28 Jul 2026 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230895; cv=none; b=FVKcndkpbgjDCZHR9/6Skm0/mZJeh1YUCC7Ci9hXtup3sCk8mHJVbWwy44laCMsccZpENxp9/HToHzIIJwHdlxOlKAqhgcvqp3KTZBdUMDof6Co540Zul/sUmHyYFNuS2Q6K8AbXRp/pLpbEQNt/w4yZs9npzuaIymvtwqTqX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230895; c=relaxed/simple;
	bh=0rHCSxyoW4/hk+nIjM/uAHvcvZEqv8d6zgmwX5NL2MU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ax+B2wnY+IznUPkEvZLyGfDDAnc774fCHeLB8iCfcuvn5hSxPCCn7PTkwKpyzTY+65iY2+hHkGYYrwBLSx6oOQ8niOGm61N5pKum5bCSKOsEInsuHs6kagQ50WctuXYRXPe+hGAf9qYrkTYVnbtVJml7kecp1J+xQcZoZmbCbFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow3Q/skB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow3Q/skB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600181F000E9;
	Tue, 28 Jul 2026 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785230893;
	bh=0rHCSxyoW4/hk+nIjM/uAHvcvZEqv8d6zgmwX5NL2MU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ow3Q/skBqyPDxOpE9Aq9FBaPt8pxMZqAVe2MnOzPwIglKvm9eURRgRgUXDsRK1yAq
	 vjUJQiqhT4+W4tka/WORch/+yrPTQLbqdWrRpnTfMmGXdfjfBpzdoTy3mfWZZwqZOg
	 Kihhg0BvaB66NUz9D5W8jLQYnBAndH1NZgasFL4m36uMWrT413NS3JpeTNdF2zk5w9
	 gRgCCIHCLis3AUQYbs5Vh+OVswTfCwxVAO2FaRJpCogne104EwFBrxXYYonxuYN/r+
	 DA091NTKlmuKPgs+JrkQmPNKGtEaevQm6gklZrjNC5T7ZQVzxs71f/P/531ZpklGyy
	 7+GZ4XiktvF/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name
 Agnostic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260728091744.1086942-2-devverma@amd.com>
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-2-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 09:28:12 +0000
Message-Id: <20260728092813.600181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Xilinx specific macros for MDB device can be reused for the
> Xilinx supported other similar IP such as CPM6.
> Renamed the Xilinx specific macros in a way that can be
> reused for Xilinx supported upcoming IP, CPM6.
> Naming is in accordance with the naming done for Synopsys macros.
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728091744.1086=
942-1-devverma@amd.com?part=3D1

