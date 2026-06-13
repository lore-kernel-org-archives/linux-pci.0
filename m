Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A6A2F1FD7;
	Sat, 13 Jun 2026 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781373694; cv=none; b=Vx+KwdAW1e3b6+LEORdcSRPXeUzaDtUqFbUa2zGHdrw2F/+SxVYgI3BUonOuQ/xzKsfBUIGeI2OvkgXNPUl0q7QPfCRUxbv192o7bpXjOG4y+8VPbpiml15NaSJZ914ZehGbQLQKbdYTS2YpWPG3gZF9aI0ZxSVsacJjWyuANVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781373694; c=relaxed/simple;
	bh=PtxzYY8LrF51wGYWbg12hSB68sznV5H6PBIDplr1lcY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Enf9jhiIsXk9LjuK8lV9Fcf0APFIvNR/Q3GOu3BgLwK/dCge2GPA8hayDI2nSBVAsfM+njZMNyql+ureipdhcTlZpcXx1IVnTpvfqqYdlOBfgqu0Q1dUqZlRe8WdF/BuKUOirQD4HiygLZRum9U1/xCz5CtuU4iVfU3Jq6n1b1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fygx1etq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fygx1etq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD591F000E9;
	Sat, 13 Jun 2026 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781373691;
	bh=6+0ZbHPmUpCUyUDByoFZ21YmlX8qYAJ3ZoVHiooDhgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fygx1etqeG6Mr97Cjhp0OBm4bwGGKFbTsvh2jKXuqMU5NwCKVf9RXz70pEV9a9cnS
	 RLVNVFQwM//9BglYjmDKimiYvLOKQtTJH81HXESWiSZ8KHbY5ZjB158oP8KZDwvTmc
	 hy8qjMti85KMsoD7Zqg8XJsoBQvYXGCaGCi8YIP0c9IRg9rPdOXUyyOHlq7rLKVfaM
	 spD9yBgZzjpAV9V4Q88OJaaxr2LQFnCyVRWhL1l1vX+fAfzuli+4Aibfv6ZCTOYQTl
	 mG49tv7NB+O7qjik0qYT18v6h2v3Y81WDiMJppoC3g0F0EN+EsuoRh4u8Iw7PxGY+4
	 maWAAuzANu5EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/3] selftests/vfio: Add PCIe Device Serial Number
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Arya" <pranjal.arya@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260613-pcie_vfio-v1-3-09168188f3f2@oss.qualcomm.com>
References: <20260613-pcie_vfio-v1-3-09168188f3f2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 18:01:30 +0000
Message-Id: <20260613180131.0CD591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Endianness mismatch in PCI configuration space reads leading to =
test failures on big-endian architectures.
- [Medium] Type punning from a byte array to structs with stricter alignmen=
t requirements violates strict aliasing and alignment rules.
- [Low] Capability walker fails to break on unpopulated extended configurat=
ion space (`0xffffffff`).

Pre-existing issues:
- [Critical] Missing bounds checking when parsing PCI extended capabilities=
 causes heap buffer overflows.
--

commit 83546a8f398b5cb4fdb341d52a4a665cb8639619
Author: Pranjal Arya <pranjal.arya@oss.qualcomm.com>

selftests/vfio: Add PCIe Device Serial Number test

This patch adds a selftest to verify the vfio-pci DSN handling, ensuring th=
at
the serial number is scrubbed by default and that the VFIO_DEVICE_FEATURE_P=
CI_DSN
feature correctly probes, sets, and gets the presented serial.

> diff --git a/tools/testing/selftests/vfio/vfio_pci_dsn_test.c b/tools/tes=
ting/selftests/vfio/vfio_pci_dsn_test.c
> new file mode 100644
> index 0000000000000..d7652ad725f4e
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_pci_dsn_test.c
> @@ -0,0 +1,206 @@
[ ... ]
> +/* Walk the extended capability chain and return the DSN cap offset, or =
0. */
> +static u16 find_dsn_cap(struct vfio_pci_device *device)
> +{
> +	u16 pos =3D PCI_CFG_SPACE_SIZE;
> +	int loops =3D (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) /
> +		    PCI_CAP_SIZEOF;
> +
> +	while (pos >=3D PCI_CFG_SPACE_SIZE && loops--) {
> +		u32 header =3D vfio_pci_config_readl(device, pos);

[Severity: Medium]
Since vfio_pci_config_readl() reads raw little-endian bytes directly from t=
he
device, will reading them into a host-endian u32 without a conversion like
le32toh() break capability header parsing on big-endian architectures?

> +
> +		if (!header)

[Severity: Low]
When a device implements no further PCIe extended capabilities, the config
header typically reads as 0xffffffff.

Does checking only for 0 miss the standard 0xffffffff value, causing the lo=
op
to continuously re-read offset 0xffc and wastefully execute ioctls until the
safety counter expires?

> +			break;
> +
> +		if (PCI_EXT_CAP_ID(header) =3D=3D PCI_EXT_CAP_ID_DSN)
> +			return pos;
> +
> +		pos =3D PCI_EXT_CAP_NEXT(header);
> +	}
> +
> +	return 0;
> +}
[ ... ]
> +static int dsn_feature(struct vfio_pci_device *device, u32 op, u64 *seri=
al)
> +{
> +	u8 buf[sizeof(struct vfio_device_feature) +
> +	       sizeof(struct vfio_device_feature_pci_dsn)] =3D {};

[Severity: Medium]
Does this byte array guarantee only 1-byte alignment?

Because tools/ is compiled with standard -fstrict-aliasing, casting this by=
te
array to structs with stricter alignment requirements could violate strict
aliasing and alignment rules.

> +	struct vfio_device_feature *feature =3D (void *)buf;
> +	struct vfio_device_feature_pci_dsn *dsn =3D (void *)feature->data;
> +
> +	feature->argsz =3D sizeof(buf);
> +	feature->flags =3D op | VFIO_DEVICE_FEATURE_PCI_DSN;
> +
> +	if ((op & VFIO_DEVICE_FEATURE_SET) && serial)
> +		dsn->serial_number =3D *serial;

[Severity: Medium]
Will dereferencing the pointer to this 8-byte aligned struct member from the
1-byte aligned buf[] cause unaligned memory access faults on strict
architectures?

> +
> +	if (ioctl(device->fd, VFIO_DEVICE_FEATURE, feature))
[ ... ]
> +/* SET then GET must round-trip, and the guest-visible bytes must match.=
 */
> +TEST_F(vfio_pci_dsn_test, set_get_roundtrip)
> +{
> +	u64 want =3D 0x0123456789abcdefULL;
> +	u64 got =3D 0;
> +
> +	if (!self->dsn_pos)
> +		SKIP(return, "Device has no DSN capability\n");
> +
> +	ASSERT_EQ(0, dsn_feature(self->device, VFIO_DEVICE_FEATURE_SET, &want));
> +	ASSERT_EQ(0, dsn_feature(self->device, VFIO_DEVICE_FEATURE_GET, &got));
> +	ASSERT_EQ(want, got);
> +
> +	ASSERT_EQ((u32)want,
> +		  vfio_pci_config_readl(self->device, self->dsn_pos + PCI_DSN_LOW_DW));

[Severity: Medium]
Will comparing a host-endian expected value against raw little-endian bytes
read by vfio_pci_config_readl() cause false test failures on big-endian
architectures?


[Severity: Critical]
This is a pre-existing issue, but I noticed missing bounds checking when
parsing PCI extended capabilities that could cause heap buffer overflows.

Looking at vfio_ecap_init() in drivers/vfio/pci/vfio_pci_config.c:

    memset(map + epos, ecap, len);

This writes ecap bytes into map based on an unverified capability length, w=
hich
could lead to an out-of-bounds write onto the kernel heap if a malicious
emulated or physical device places a capability near the end of the extended
config space (so that epos + len exceeds pdev->cfg_size).

Additionally, looking at vfio_pci_core_feature_dsn() in
drivers/vfio/pci/vfio_pci_config.c:

    WRITE_ONCE(vserial[0], cpu_to_le32(lower_32_bits(dsn.serial_number)));

Could this directly write 8 bytes to vdev->vconfig at pos + 4 without verif=
ying
that pos + 12 <=3D pdev->cfg_size, similarly writing user-controlled bytes =
out of
bounds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613-pcie_vfio-=
v1-0-09168188f3f2@oss.qualcomm.com?part=3D3
