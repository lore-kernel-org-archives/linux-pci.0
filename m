Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672308;
	b=NrfsspUkEVOjGZB80SocyckcxTZXO04JV6TjDpQWdoipKXjqhfcWMHoRa3apLB8vqN3q
	 vclbl0MSAsmjimSSGceoPI6lCfb/NVwJCieM013XhQSW+M8+udogqGIAtjTQOKBgv3zXE
	 IasDRD/K8F5/i7UHn1kU4+HTB/OT7gVcDSzr37GUV/qk7enMtTMt/fRnE2PbMxYejqPJA
	 +idGvuYMPvhuiTq0pLSt88E9+tMtVniOPshntRq8K9Jx4N1PbEYO8AWeK7TnJ9CVH1Cin
	 SZOvwjsgrvdz00uX0wM/2+Cyaf8CKDjJwWgfSM/AHtAGLhUiJKzBrS4y2wYnNzGXlaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672308;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TJA5eVYFjiDmwtR7AqgOtOfYgupzOFGAcJXQ9YWdRG0=;
	b=v4/3/ycLDbajz1H25NFEzd4wQvjTyrAhgEA8qUIwZfW1zqu2NXocYU2sFVgeYqCkKHQ4
	 laGkDd1nwoDOApJq0c9Iuw+j5aBpV/7rccVmgumrXFOgLFs7zRrHuC/xbQh7AIXHlw31/
	 3hIHY7sgn3B+28PCsGW0nw864ixSQNTTpzlvwbrKOcZ/wyGkEheyw61wx94QaGPPGtPXF
	 FbV+8Ubk3eblkZA1M5W2aSlqoiw5HOScvjshLW1mqITtxpG5B3ryZdvRTEED0Y+SoKqQl
	 4N9UOlEyIhK+3VdoGqnj0gSZ0lcRxxm2N0FdCRoTVoZALnzPesBzNMOn8fJBi+kwMEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g3qzt77/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D340606A31C
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3qzt77/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010B31F000C4;
	Thu, 26 Nov 2026 05:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795672308;
	bh=TJA5eVYFjiDmwtR7AqgOtOfYgupzOFGAcJXQ9YWdRG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g3qzt77/qk03NX80HMPhOaSE1gW4uAo81MQ24rtunPo8V7DipecgnGkU1A96Xvjha
	 iD7B9dXmKx7lZ2dNpHUPaeniD6RjoU5ZhQr4HeRWrDYqIjHxrK7t2iz+52oyZepGSG
	 2mCGKO+6iSoMoJAuTdAHy3Zt+CZvZxpEAMIGkJVsdJ3XvSxs/4CxmLkY4vlmJbvscV
	 BIwAcBmFHUaddyfxA0OSECCyS/0rwsGbis4vwNck+ApMfek0dLoFdPG+b59XmZh98J
	 pt1Ns2Z7CfZLDST93yn3nsjKPQ5NhFXMMOYCDH+o7HDV1G8gQochiGCZ5207yiV9qt
	 QQXIywv5JVJCw==
Message-ID: <sashiko-outbox-234807@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: Skip ASPM enablement walk on resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261126-qcom-aspm-resume-v1-1-a34625656e92@oss.qualcomm.com>
References: <20261126-qcom-aspm-resume-v1-1-a34625656e92@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 05:51:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: qcom: missing Fixes trailer for resume ASPM walk regression
--

commit 8ccbd3dbda372079aeab1a99e5812e536fb23323
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

> PCI: qcom: Skip ASPM enablement walk on resume
>
> qcom_pcie_host_post_init_2_7_0() walks the bus and calls
> pci_set_power_state(D0) and pci_enable_link_state() on every downstream
> device. It runs from pp->ops->post_init(), which dw_pcie_resume_noirq()
> invokes on the resume path in addition to the initial host init.
>
> On resume, the PCI core has not yet restored the downstream devices
> saved config space, so the config accesses performed by the walk fail.
> With a PCIe switch in the topology this is easily hit, producing errors
> such as:
>
> pcieport 0000:02:01.0: Unable to change power state from D3hot to D0, dev=
ice inaccessible
> ath12k_wifi7_pci 0000:03:00.0: Unable to change power state from D3hot to=
 D0, device inaccessible
> pcieport 0000:02:02.0: Unable to change power state from D3hot to D0, dev=
ice inaccessible
> pci 0000:05:00.0: Unable to change power state from unknown to D0, device=
 inaccessible
>
> The walk is also redundant on resume: the ASPM link state is restored by
> the PCI core as part of the config space save/restore. Skip the walk when
> the controller is resuming, which is the case while pci->suspended is
> still set at post_init() time.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

[Severity: Low]
This fixes a resume regression introduced when qcom_pcie_resume_noirq() was
switched to call dw_pcie_resume_noirq(), which invokes pp->ops->post_init()
before downstream config space is restored.  Should this include:

  Fixes: 2cc0e7454c78 ("PCI: qcom: Add D3cold support")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-qcom-aspm-=
resume-v1-1-a34625656e92@oss.qualcomm.com?part=3D1
