Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A033101A7;
	Fri,  8 May 2026 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271595; cv=none; b=lpHaxG2FSuu7oBc6OlLl4EOVQjh9OjUQX7a2K3Dvby1lECI2CWMTPUyKxKdVkRbAcEGyWlFGG/hCOH7Y+EIcV8Iui5L8CgvTHrzQV/6g8j6rNWvuMVSGw8bGLcqhNR5kCb4z3WkZFoHGbANsaG1O1ykF3r8bufAjf8NWPZqRDdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271595; c=relaxed/simple;
	bh=L1FtKV36RSlwVHOa4wY21cgtKWZbfF1ybSXX+fMEeIo=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h69Mrzq76QVO1idDCn0x4hoWT/PtbYd7VMVyxOSY8Oh9ia1U93m4Jl8oCk0BW3EYIHKXlFPUK35niwU1cyrcohtZoI0SCM0N5m2gPQ7ATl/s/bn+o9bJLLEL8lfYEAn8/bxFxdPFb03YnKvCWNBthhexUwnH7GNodHZgPorKnTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNSKTqtb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNSKTqtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60231C2BCB0;
	Fri,  8 May 2026 20:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778271594;
	bh=L1FtKV36RSlwVHOa4wY21cgtKWZbfF1ybSXX+fMEeIo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date:From;
	b=qNSKTqtbhnpi4tvUeJ/NMDdXtRcxfz6WHsiXLCpKLW2WHw/a8vKE9r7U0qgbwg43h
	 X0F68TGkKSUUonxdageaP8pv0Ux6I75pA9RVZzG9tzAGq2HgUdrUe7IZby+/9hNced
	 FwgLO/VpICRomrzNpBj8Xq2iD4hZDIKQsrjc7RcGzzK/BJdcSrPNhzTAjhRAc4DrJ4
	 zTLxvrTDyLi100CwhEU2R07W1dIERJnmOf/caVUDVRJXjdbpNZ2qgO0otfL4swpx+A
	 JIFj3YYA9GXuNgiM3ndMpDaJQpYaLopxRRScDzaEDcWmnjSC56NdgvWDqsFB6Uo39T
	 o20RcQbfUxv0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dt-bindings: Fix phandle-array constraints, again
Reply-To: sashiko@lists.linux.dev
Cc: robh@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260507201749.2605365-1-robh@kernel.org>
References: <20260507201749.2605365-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 20:19:53 +0000
Message-Id: <20260508201954.60231C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `maximum` constraint for the 'Single bit index to toggle' in `q=
com,smem-states` properties is incorrectly set to 32 instead of 31.
--

commit 20348129b7dc793c517f442ef59bc8d4f2293a0e
Author: Rob Herring (Arm) <robh@kernel.org>

dt-bindings: Fix phandle-array constraints, again

The unfortunately named 'phandle-array' property type is really a matrix
with phandle and fixed arg cells entries. A matrix property should have 2
levels of items constraints.

[ ... ]

> diff --git a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml b/D=
ocumentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> index b30544410d092..33746c238513d 100644
> --- a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> @@ -42,7 +42,19 @@ properties:
>      description: State bits used by the AP to signal the modem.
>      items:
>        - description: Power control
> +        items:
> +          - description: Phandle to the Shared Memory Point 2 Point devi=
ce
> +              handling the communication with a remote processor
> +          - description: Single bit index to toggle in the value sent to
> +              the remote processor
> +            maximum: 32

Should this maximum be 31 instead of 32?

A valid bit index for a 32-bit value ranges from 0 to 31. Setting the maxim=
um
to 32 permits a device tree to specify an out-of-bounds bit index, which co=
uld
lead to undefined behavior if a driver shifts by 32 on a 32-bit architectur=
e.

This maximum of 32 is also used for the smem-states additions in the other
bindings updated in this patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507201749.2605=
365-1-robh@kernel.org?part=3D1
