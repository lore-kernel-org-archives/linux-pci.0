Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C03624B3
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714512; cv=none; b=P7Ftlo4hLiwg0Tp3Escr+BNNNPNvHZQwOWG2SVCGQ1jaZRmJm4fWJtTLMnqLcbmsk/vw0l2kHNDCpGTH4l9Wy+G+uPrJ26Ri7wcz+HrMVwusn7ID38lxDRBxG7KwA5Fut6PH3sY41UwxHHAclGCvFExl/BTIMkjAXoHcT9gayA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714512; c=relaxed/simple;
	bh=cIFR2n7HodH+DtDShvK2NfklJjc9ZbP+dPiXP2zn8fY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GJQJonmdutKqimN9ZqtRY+Z2djUmtNUkQ6Z4ycBjU3jUhZPppu+JqHYMmq2Td2BIdleEtyHumz1zIhIOxDZUD3Wib7SSzBxWIxqmFGo7habXng8ZNfewDC3ok+YIn9/FTkcyPv6txS7vVMIiI03wWhHfWSyHdHfiRiPSdwHyySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU/ZgNKW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU/ZgNKW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7DF1F000E9;
	Fri, 10 Jul 2026 20:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783714510;
	bh=cIFR2n7HodH+DtDShvK2NfklJjc9ZbP+dPiXP2zn8fY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aU/ZgNKWQDCpDx0jKTupscsyFeFkt1st1oSD1ZLdcUzU6S+FmIu7qdfd8Hua96HCp
	 5eI6Mn7UE23tOcqhxdDIupk3JIp5c2RX9gg6IrrAGBDRkBx7Ru0hghAzoVYtCuj1XF
	 2NV2bJ24jHTo5tFtyq+hF82OcoZknk6GhVje/mSSJoLNoUbBM5KuB9dNEax5P5qHuP
	 pfSVb6weE3DkTdKmt+a5rDHTARRqWuNFTgCe7wLbylXQumuYDM+rB3BhJeWBUg3QKN
	 SdkGl4gVWrBHK94MdsEvzI+4k+UiApucV4XonwuWmHG/ASAdEetObk3o9zhJTBEek/
	 gB1+nwGbl36aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Only assign OSC features in bare metal OS.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmal Patel" <nirmal.patel@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710200558.499434-1-nirmal.patel@intel.com>
References: <20260710200558.499434-1-nirmal.patel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 20:15:09 +0000
Message-Id: <20260710201510.5F7DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Copy valid OSC flags from root bridge only when OS can provide correct
> values. In virtual machine, all of the control features are disabled as
> hypervisor will not passthrough root bridge information to VM.
>=20
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710200558.4994=
34-1-nirmal.patel@intel.com?part=3D1

