Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305968;
	b=H7QUEtokhz/3Vihle5/yOFvqIwdhiL2HvtyCS1iqXFqPzyb50kqDzLzBfKCzX/TwenSs
	 zUFJHEHry/ijUQX5o75Ug7g2uayq0dO/wtCrDOUkEiQbpCFS1gLTd9+LtEUPNq+gCK4Tb
	 +OSLZ14k0ABjmSahsYwOyLK9XIVd2opcQpZlJPc0spgj69/ahbDx6VYMGVk5T0+0Pfhtx
	 YcDVrA92ARcjJpCDrNktUJv+o/CUdP0dOxqtjiA2SEWh6cHRptOa8+uk2HG7bNuznKloz
	 QcsrAAkw6MLlWvPCyynE5cZouBIWAr/VC9tHT6tqajumoJ59Ue9bbUZ2WbsQb4J2wsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305968;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rrTU4zA6n+EMdr8hQ5WKxPsZwXjXAp02tKq68n/jH2s=;
	b=jhNu4q0olKWwJ4mzVNtI8owaI1g/+aRDdlBvS1MfHLHdGMPHoe+MlfHWR6F4iMa79T+z
	 w//FilKb8/wTFLh1odtr1AFBFDAPXK/7nLeRAMCUTG6Rdr8uWLgl/x1LI8Olo6wNom+NZ
	 9qU0LEEyD0yMHfVraMzZMBas9Gv5sa3eBWos2GI0plIUpD7FbmBLjllWjIvJTsqfpzLft
	 vgkzmDhf39OJ4S1vqnrRVVFjEClVfiu4m9HJivP7DZxGn7wUCkV8vUHjBucQwa6lDLquI
	 YfgzHHitBM9/66jGuVyHL1RA3oo2K/ZWT7ERz150+ewSX1FBym6qB1d0X0oBl9wladg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgj3CHAh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D43606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgj3CHAh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5817E1F008A1;
	Tue, 10 Nov 2026 10:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305967;
	bh=rrTU4zA6n+EMdr8hQ5WKxPsZwXjXAp02tKq68n/jH2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jgj3CHAhJUMh4vXAsdN/fGPvHJzP5EgXref8swhbuo4Ujy849dSO/14lVXFrgnbqn
	 UjxzYk5GtxxvWQMF9DegSHbaqCftvKRa/RiI9QaNTLJMWXy5/G0mAm1nrMCvsXwrWM
	 ypd/gQoEAk5Ppt7vh/vA7eq1i+fS4Z3S8efcx3V1PQa3F2bNU+MLU4fRo+3RfLk/Nl
	 pqp1u8WOpaHW8/i1r0M4EkpLwCffOFs92bXdg+vZpmnmhDwnzt/DkOCPfr+Lkm1T4D
	 PdSSEG2xx9aPsGcs7hTdjhJTlAwdkNp4jCXkNf0VIwsyXr5rVeKUXu74UwyRgDc70l
	 yS4O/NDalB+Jw==
Message-ID: <sashiko-outbox-206857@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] PCI: keystone: Fix device node leak in
 ks_pcie_init_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110100955.1046-2-zhaofeng2@cmss.chinamobile.com>
References: <20261110100955.1046-1-zhaofeng2@cmss.chinamobile.com>
 <20261110100955.1046-2-zhaofeng2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 10:19:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
>=20
> ks_pcie_init_id() resolves the "ti,syscon-pcie-id" phandle with
> of_parse_phandle_with_fixed_args() to obtain the device-id register
> offset, which takes a reference on the syscon device node, but the
> reference is never dropped after the offset has been read from
> args.args[0], so the syscon node is leaked on every probe.
>=20
> Drop the reference with of_node_put() once the offset argument has
> been consumed.
>=20
> Fixes: 7dcf07ac8867 ("PCI: keystone: Use phandle argument from "ti,syscon=
-pcie-id"/"ti,syscon-pcie-mode"")
> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110100955.1046=
-1-zhaofeng2@cmss.chinamobile.com?part=3D1

