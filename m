Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792902623;
	b=CEP2O8hJI3ncGIIshqyJR3Zvi/rAQ95P/zFdlJuEVK+6aVjRi816welvqckb6tnyU9jS
	 8m2DxZsTt35qU+rHhn/tYzAfC7e76my+NsO8/VpZd5OCSMcA4FXSl/NGnoWDekAzc3jIx
	 vIe+IPxkwwB8PdNAMwihMUwBFSl6Ko4cMgXhR+8hPJvhmG4zY6cKH5vYQcCUKa9+vKYdl
	 a/AF6ti/Invb36fZfg9T0SYMOioj/lqRgJ2vuG4rJqdfRNQoiCCurKHg2XIjgbxJqMRVi
	 aiZWqviQ9wV1XGV4snmXsZGd6JqN9QGeaUUZoHT19Hkm5G97a8x3Ewfb77y/Ev8JTrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792902623;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2QQcs87YaWMya2pBYkAwd1G49GEHG9Z7e4/sZPzlK3Q=;
	b=UTITamSurMyyjNAECcpYmD/hi/7WBq9hf083CQcdCRmpCmwWQ1zOcuzoDEEg6K/QwmXF
	 3dO9AQiSat5w3D5ZfP2qsHIhW8mm+A7tHIw3CLT/cFRUsuSHF/NlFOVBrycSmDA1rnPuc
	 lvtTdJ1PrvCU20rWyDuYSex29WoHQk/wu2P+N2Sy+nb+zR/Ioc8VM14bXosp9AQbPahqg
	 l0ljfZpmPOFRzdCt+Omd2zJs4VxUjEzn0Mft8y3XLa9Cd+mFSMrj2khGhaPR7FCvtPSuS
	 xcfALMqc5G+asJB2DSQIhS00DCV9Emu8qkAyDAxPdrSuk4STd08hi7IhLonpNmKdGfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AE4TFXUg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17EC606A31D
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AE4TFXUg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639C71F01825;
	Sun, 25 Oct 2026 04:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792902622;
	bh=2QQcs87YaWMya2pBYkAwd1G49GEHG9Z7e4/sZPzlK3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AE4TFXUgoNIOoke4H01g1kZXmFqrq/oyP1WkMpGo2aI7pn6KbHoJbXY9px9V3Djgj
	 8e1U712SjOz4ADDr1KSUzrjFlDUi+uQA3yYwpT6yxpgSpcXsyW+UVDPkV4D3rLByox
	 Ovf65odSW1TPdmCzdLo0VjokB/yNFupuJ58gOIcnrRZPaOEq/QYyYILYnIO+aMXdci
	 45tcT6oOcXVB8sgHh1UB/EokPTUPu1iEnFdDaMIDo5n5QpxDQ3DHUfX0O3MEhW4G1G
	 xMixa9raIgYCAyUAwL3KPBE+YbJimSl9V9FP/7dGLMfCTUpq3k1+/ceKxmFW5ng12Y
	 1ldaIQxDf3+Hw==
Message-ID: <sashiko-outbox-184066@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] drm/amd/display: Skip panel power savings on eDP
 links without a panel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-14-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-14-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:30:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/amd/display: KUnit test failures in amdgpu_dm_should_create_=
sysfs()
--

commit 7217c1895d0e9a0b0a4343bbfd37bba3770b7920
Author: Andre Eikmeyer <dev@deq.rocks>

drm/amd/display: Skip panel power savings on eDP links without a panel

This commit updates amdgpu_dm_should_create_sysfs() to return false when
dc_link->edp_sink_present is false, preventing creation of the
panel_power_savings sysfs attribute on eDP links without an attached panel.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 703d0617df6d4..c8fbd2167b6b2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -761,6 +761,9 @@ amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connec=
tor *amdgpu_dm_connector)
>  	if (amdgpu_dm_connector->base.connector_type !=3D DRM_MODE_CONNECTOR_eD=
P)
>  		return false;
> =20
> +	if (!amdgpu_dm_connector->dc_link->edp_sink_present)
> +		return false;

[Severity: Medium]
Does this break the existing KUnit tests for amdgpu_dm_should_create_sysfs()
in drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c?

In setup_test_connector(), fixture->link is zero-allocated with
kunit_kzalloc(), leaving edp_sink_present set to false:

	fixture->link =3D kunit_kzalloc(test, sizeof(*fixture->link), GFP_KERNEL);
	...
	fixture->aconnector->bl_idx =3D bl_idx;
	fixture->aconnector->dc_link =3D fixture->link;
	fixture->aconnector->base.dev =3D &fixture->adev->ddev;
	fixture->link->connector_signal =3D signal;

Because edp_sink_present is never initialized to true in
setup_test_connector() or in the test cases, amdgpu_dm_should_create_sysfs()
now returns false unconditionally in:

- dm_test_should_create_sysfs_no_backlight_index()
- dm_test_should_create_sysfs_oled_cacp()
- dm_test_should_create_sysfs_lcd_panel()

causing their KUNIT_EXPECT_TRUE() assertions to fail, while
dm_test_should_create_sysfs_oled_no_cacp() returns early at the
edp_sink_present check before testing the panel_type and cacp_supported
condition.

Should setup_test_connector() or those KUnit tests be updated to set
edp_sink_present =3D true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D13
