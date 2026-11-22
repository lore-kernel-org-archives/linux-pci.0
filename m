Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795317560;
	b=pjmrpjw24QfjxFf+E+UqEp+dceMPdObZDbHSs++nXeRlOl8TIExTjA1buL0LJh90fhxx
	 EgpdXJ+owYMg+mqrh1kfbN8d4YFHh/aq706vkaqbSUPTU/NAwcMec5QYJtLJuKQEvq8IA
	 8drWec9DIX2fMmtJw5eGwa9zVtuv03hX/jJOAHl4kASDMqXZzYVcn/tsZ00822hUfY/Ge
	 BhpxYpBLUKvAyHwvXVoQQ+cj3Gkf3TMXk8X10Nnrk0n00566mcy9+QpSAXT3p74BI687k
	 0bdIAp8Mvyz2TrB/dj8/Pb82acdlAEkK5aoZ5Do5EZQKQKy+t3+t2ExdKQ7MLXfj6Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795317560;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fy8V29D8kYwB6Exatu7VPdyzmc2sUNsTaNpcQ+njmJg=;
	b=a3yI+bXbTzFc7UgNpn8IgV7wV99ISa9GrvEORR/im/CDJ7Jz2AnNPSNUzvMMXIBQVN4v
	 ajXdysXvZKEoQrkGslnkHXTA7q49IeLZO+DJi7VWHaujmAVCke6Xs1k5WDOGlZ38SQlq9
	 syYqBtoxTRbscjhkqMgeyngxHE1h0LguG8QxEDlbmAysD75ag/f0/hZXBNeJBY3UC2lZ+
	 QSFcGOH04K/Ug/s2HA/9q+l97EJZaj0mqatyvvpTA/J46xxEcccE8C/ixhylTdsHsKFvu
	 R7EdNWsSmomcZNDShc5Q27DJO3kPWKrnfTpiGZTCpD6Q69UluxBJ7JHo1Z+eT9nmy2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a9Lsb/FX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A3606A320;
	Sun, 22 Nov 2026 03:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a9Lsb/FX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F041F000C4;
	Sun, 22 Nov 2026 03:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795317559;
	bh=Fy8V29D8kYwB6Exatu7VPdyzmc2sUNsTaNpcQ+njmJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a9Lsb/FXYTzMUOFS13AmCjw/7nXycTZGmop8SvOa9yod/pUfIxCvpnVM0YaK+dl0S
	 BR1LmG+QBjs/5BT3GKWwgIU1hVvfbHJ4UL7xkgiUumi8b7r3D5l59UZ3XC7OJDxhZO
	 oXR3SLjRgY/+KSdB2o+ZVBbAWm/QTCPAodrO9tSnHZ1qWUZrvx0fmh+NE9inrIO3FI
	 UGWaqUu5seXiW1z3SJL0HiwmUWlVs63RT2aURGuBtOF+vZHVd19tmDuWxQLOosa9rL
	 nSPjlHzSNG4p9HcTS6L4BoFfi9sEsytbZTcrm6T089DawbHOA37xEHEF4zKUiGqCEk
	 wfwolksc4w8+Q==
Message-ID: <sashiko-outbox-227669@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] bus: mhi: host: pci_generic: Add support for
 Qualcomm Nord
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-phy@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261122-nord_ep-v1-10-6d8839ffa9aa@oss.qualcomm.com>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
 <20261122-nord_ep-v1-10-6d8839ffa9aa@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 03:19:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] bus: mhi: host: pci_generic: 0x0120 wildcard class matches
  QCOM Root Port
- [Low] bus: mhi: host: pci_generic: unsorted PID 0x0120 entry in
  mhi_pci_id_table
--

commit bf997d1ac5e3f263dea66560b3e85c9fdd9703e3
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

bus: mhi: host: pci_generic: Add support for Qualcomm Nord

This commit adds an MHI PCI device entry for the Qualcomm Nord endpoint
(device ID 0x0120), reusing the sa8775p MHI controller configuration.

> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pc=
i_generic.c
> index ca9ef4aaa0140..65201ec8dc76c 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c

[ ... ]

> @@ -966,6 +977,8 @@ static const struct mhi_pci_dev_info mhi_netprisma_fc=
un69_info =3D {
>  static const struct pci_device_id mhi_pci_id_table[] =3D {
>  	{PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0116),
>  		.driver_data =3D (kernel_ulong_t) &mhi_qcom_sa8775p_info },
> +	{PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0120),
> +		.driver_data =3D (kernel_ulong_t) &mhi_qcom_nord_info },
>  	/* Telit FN920C04 (sdx35) */
>  	{PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x011a, 0x1c5d, 0x2020),
>  		.driver_data =3D (kernel_ulong_t) &mhi_telit_fn920c04_info },

[Severity: Medium]
Does this match 17cb:0120 PCIe Root Ports in addition to the Nord MHI
endpoint?

Device ID 0x0120 is also used by Qualcomm Root Ports:

drivers/pci/quirks.c:pci_dev_acs_enabled() {
    ...
	/* QCOM Glymur root port */
	{ PCI_VENDOR_ID_QCOM, 0x0120, pci_quirk_qcom_rp_acs },
    ...
}

Because PCI_DEVICE() leaves .class and .class_mask at 0, udev autoloads
mhi_pci_generic for 17cb:0120 Root Ports, and if pcieport is not bound
(for example with CONFIG_PCIEPORTBUS=3Dn or pcie_ports=3Dcompat),
mhi_pci_probe() binds to the Root Port bridge and tries to map BAR 1 as
MHI registers.  Should this entry restrict .class and .class_mask to
match nord_header's PCI_CLASS_OTHERS?

[Severity: Low]
This isn't a bug, but the comment above mhi_pci_id_table asks to keep the
entries sorted by PID, so 0x0120 should go after the 0x011a entries.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-nord_ep-v1=
-0-6d8839ffa9aa@oss.qualcomm.com?part=3D10
