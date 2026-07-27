Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C53B6370;
	Mon, 27 Jul 2026 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167795; cv=none; b=SrkFc2qpalmEwIlH5RgKRBHdWnq/bZ2Cp50IlJA2+BvR21k+PS7PwNPvk8f4O/jbMZDCojNCt0YqExO95YE2muP5/Cm8RbK6aOIYX6Q7HzQLvvvPuSmciH//cfhgK8VoAyQAJEJy0fk8+XxZ+FOPRLB2a539XH+JWZzh90G3abE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167795; c=relaxed/simple;
	bh=OLr+kd517dNsGycJeTlnXw8491zZNF3THtftEKILQsg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oSkwyfazKcWVB0sxb96pUjBUBGgAA6cGyJ+Fh2lmJ8ua6zic+61FGarUyPWRzeeSrEvSjD9XpxejXDWjmpuk3lvMitv+4VL0C6NJqhtX9Kp0W/+PdBVEI+4KgoaeEwKCDHs4/peRJO7B60/DFGE4cwIK8ImMtHawXSRbuq7Fqqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+689j4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+689j4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60CC1F000E9;
	Mon, 27 Jul 2026 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167794;
	bh=HS8TPqdBirCcKG1iT5ZnQFRDCGZIrchusFK/b/PwXBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+689j4Mgyi8v5e5yQqohY7llRYMN0Pz4U4e6M/977Umtzo0I5bXqww8VlKBRELHv
	 gcHAYUPDlkCKWRGmFzsOaXEruyfekaomIa8TgT5hKBsQ0+V4du6F/zeC0LJ9FDFQBL
	 VVzRqoDEaYtMPctWGTZfmn1ApYljoS8eytbseD0ulj+VzJLewAnH5+y428u/LXVRBU
	 kHOTjdVfdoKWSJYn+HNG5AAi8W0dy8YK8UtaWN9VkiT0oG0NoiamgSu3PJvcIspDyj
	 +xbf5v0+6KMokUIyRwjySoF7ZGAZTbAh8DWHvjxKLfXXzhvHg2dNBnSF7XLGFl0UkC
	 dCxBkNPBqH07g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] Bluetooth: qca: add QCC2072 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rahul Samana" <rahul.samana@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-2-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-2-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 15:56:33 +0000
Message-Id: <20260727155633.A60CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional prepending of a Type 4 TLV header leads to nested Ty=
pe 4 headers if the NVM file already has one, silently breaking NVM parsing.
--

--- Patch [2]: [PATCH v2 2/6] Bluetooth: qca: add QCC2072 support ---
commit 6bcb3bc10729db904fa228c76a2bef00327ec17a
Author: Vivek Sahu <vivek.sahu@oss.qualcomm.com>

Bluetooth: qca: add QCC2072 support

Adds support for the QCC2072 Bluetooth controller, which uses ORN firmware
naming. It introduces a helper to combine BCS calibration TLV data with NVM
downloads and registers the compatible hardware.

> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 10c496eaea2c1..34bc0684cf1b6 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
[ ... ]
> @@ -569,6 +569,54 @@ static int qca_inject_cmd_complete_event(struct hci_=
dev *hdev)
>  	return hci_recv_frame(hdev, skb);
>  }
> =20
> +static void qca_combine_nvm_calib(struct hci_dev *hdev, u8 **data,
> +				  int *size, char *calib_name,
> +				  size_t max_size)
> +{
[ ... ]
> +	outer_hdr =3D (struct tlv_type_hdr *)combined_data;
> +	/* high 24 bits =3D payload length, low 8 bits =3D type */
> +	outer_hdr->type_len =3D cpu_to_le32((inner_len << 8) | 4);
> +	memcpy(combined_data + sizeof(*outer_hdr), *data, *size);
> +	memcpy(combined_data + sizeof(*outer_hdr) + *size,
> +	       calib_fw->data, calib_fw->size);
> +	release_firmware(calib_fw);

[Severity: High]
If the original NVM file already contains an enclosing Type 4 header, will
this unconditionally prepend a second Type 4 header?

Looking at qca_tlv_check_data(), it expects to peel off at most one Type 4
header before strictly requiring a Type 2 header:

    if (type =3D=3D 4) {
        ...
        tlv++;
        type_len =3D le32_to_cpu(tlv->type_len);
        length =3D type_len >> 8;
        type =3D type_len & 0xff;
    }
   =20
    ...
   =20
    if (type !=3D 2)
        break;

If there are nested Type 4 headers, the second header will cause type to
equal 4 again, which triggers the early break out of the parser.

Could this cause the driver to silently skip parsing the NVM data, leaving
critical settings like the MAC address, deep sleep masks, and UART baud rat=
es
unpatched? If the baud rate is not updated to match the host, this might
cause all HCI communication to drop after the controller applies the NVM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-rb3-indust=
rial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com?part=3D2
