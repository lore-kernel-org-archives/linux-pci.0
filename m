Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0134E744
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275328; cv=none; b=RfnK6Bz9bkXI/d9mfhZpsIAAqlCFD8pDxyvvjZGj3GZgbaS4se3MN1Vn8bdR5Wg0SzakRw7R8/lQumOCeT8XWHk2sf1JLjX/i3tiAzEDAgIz2fsoL7bu3N8KIEWAlyxmteA6dhg6Bo2qXBqUWxS/aj20XIGGZz3creT2H8Gblrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275328; c=relaxed/simple;
	bh=WZ5RFBMGjvagUnYCsmLWB9DmfEoqCkrFFnBNIkK09Pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mcluQFEq4jWHAdW12qxPfT7eWcP+IzS2TvufVoodHtWSr/5WGj+ycORF54K/hVOdmNevJaFX4ey2lpwZkx1ebbzNWqlYJTlNqPo9IRo7TLUXwNI1eaA4lFcKQpJKzoAsiIk0KhOhHbEENWX/ZMc4qPXsSgfBVOnyEQjqYB+SUto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVCXinJG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVCXinJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2544FC2BCB0;
	Fri,  8 May 2026 21:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778275328;
	bh=WZ5RFBMGjvagUnYCsmLWB9DmfEoqCkrFFnBNIkK09Pw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GVCXinJG7A6HRDky9C2iWJPiAglJROayk4MouxPqKB8pjf5+2ptUzFb00d/5412m/
	 IrrBNu6IjYUk+b4p/T9q+caZDu2VAXnrpNgO+2yK7zozM9Wi2ls/Cw3kszZACjx5wb
	 ZJsFrv9kqP8rYYanqeHwbRrNaXxnJ87W7XfA2CAr8Scd+oKVEUtKUOQvsQs74omeJZ
	 wjvFPtmDqxtEb6dmVeEEvDHk3sUXkGVhI6N9KtEmh0OhosxPsY3D4QRBOPCC3oalKG
	 LEhRCSN1WLLgIXt3SjIu0pttCOYN5NNWOqlME55hdCveIM0zytXVQeLRNdYjI14P7Z
	 MlQcDhB0D12vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Disable broken FLR on MediaTek MT7925
Reply-To: sashiko@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508145153.717641-1-jtornosm@redhat.com>
References: <20260508145153.717641-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:22:07 +0000
Message-Id: <20260508212208.2544FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete implementation: Missing MediaTek MT7925 device ID `0x=
0717` in the FLR quirk list.
--

commit 2cb7494208e4978bb4c09df85e374c7eac96b74d
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Disable broken FLR on MediaTek MT7925

The MediaTek MT7925 WiFi device advertises FLR capability but its
implementation is broken, causing reset to fail and leaving the device in
an undefined state. This commit disables FLR for the device so the PCI core
can fall back to working reset methods like PM reset or bus reset.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc02..e49136ac5dbfb 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
[ ... ]
> @@ -5619,6 +5620,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x17f0, =
quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x7925, quirk_no_flr);

Should this quirk also include the 0x0717 device ID?

The MT7925 driver in drivers/net/wireless/mediatek/mt76/mt7925/pci.c
registers and supports two MediaTek device IDs: 0x7925 and 0x0717. Both IDs
share the same initialization logic, MAC behavior, and firmware.

Since 0x0717 belongs to the same MT7925 family and shares the same
underlying hardware IP, is it likely to have the same broken FLR
implementation?

If so, users with the 0x0717 variant might still experience the VFIO
passthrough undefined state issue if the device is omitted from this quirk
list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508145153.7176=
41-1-jtornosm@redhat.com?part=3D1
