Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE142CAFC
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583074; cv=none; b=hhJ/+H3VWNzi8fImL3lhJfbIdCpnhGaDOQ38KTR1qfuq0h8WBIOOTYokbFrgdwkdc/7FXZQYWnhsVgG6d7hW2POp0yJ344+IpmLJ0b8zPE3wvRQh5KBoa8/SfI6on7ZuGar636/qMUeebazbGL6JvpnHmrUfUS4WlBqdFR6zIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583074; c=relaxed/simple;
	bh=S5mORuPLa/H6B+L0LBYKGkgs55T+O1K2vC29WQn3kz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgvVw1BLTs7bV/L/vt97b/xMhTKv74qsx/3FJA3nlQY9zuKfzCLz0nXq6GkjV/hyyMVoPO4My4Gag8TVFkAeIL3Eb2GncrWRYEf/e9VFjsDtUEQCPesigEHxMYvbD+is2+HLqkZjy+0hG4IKVCNUkxEi0uwsOSYdZckJImTwEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DOs0H8bD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ct0qZVq4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DOs0H8bD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ct0qZVq4"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699KhiFY2857985
	for <linux-pci@vger.kernel.org>; Fri, 9 Oct 2026 21:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JFTiCOyMYyYprZFMJkvWgHkm
	QqJOo0bknLkPDyvBAUk=; b=DOs0H8bD0q7aCTx3Q2V7jvpoWVfxpM7RiWfm8A9V
	S8cfZeITrn2msJVkhdUYaQFx2dy3QrXBhBDic2PSpJupdq0prUF07BnZ3PTzazyN
	wMgD3X7PJO8IqIYXQ4dViPu9xYF4U//GmYkgQdpExK4mJdvlLBghUlfSE/vu8SEO
	Wg+e/IlJ8GePQBfJ56Bd+/djiO7d8pkj5UUjG1xciJQtawzkIkxPPTRavuY31twY
	9Lf2KerEATHN2rfzZaa3TL3wwxmMRg6osTikG/tRsuVHiRQKY3tROGxgP38W1WBh
	wkltPAkEK4rNP7lEulP/iNkodE1MhSkwIMH76Drr80QSlg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t88tsp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 21:57:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb6391e89so30709485a.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791583065; x=1792187865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JFTiCOyMYyYprZFMJkvWgHkmQqJOo0bknLkPDyvBAUk=;
        b=ct0qZVq4IH4omSqxY7rkjVgYA7bzCLDBuFSskPakAbxgwIbYRR223atHAaWcsfVSOz
         DJl8p+wfkV+yTYsN6fTs6TQcsJ0mor6iaMV9HBCijz2w4qvtqOknXY3C0miJFk2KAwmy
         KpvPenTxAzZ0A2GO3HxinM+3R28MfH4pRuOilunNDCDbfqYti4R5gRz1kzhOmqfRf3cU
         oYXAuyBdTvVnT9SzDTxGe0rcqWno8bbw9peMG7gy8kz5jCjUO+JZklaSuwiGT+H/ALxn
         0TsqAqmu1gXXmz2TsRj+jY+wcxcuSabiCdo3v1aaCdBfLI7dDdtUzbEX5x3PFqm5G2lv
         9/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791583065; x=1792187865;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JFTiCOyMYyYprZFMJkvWgHkmQqJOo0bknLkPDyvBAUk=;
        b=KC0QLwTomZ5MUgEp1K3mKc6Q15UU462QI1FSUc2AN3V0GUg6W5tQLwezzheigaXCel
         88noCezzL25Jvrhgom4jhV/VpyH0LXHDRzD/bvVQcV3LxNJHqKGlLXEp2dSpmRh83Tj5
         iBw0MmnEnDwjv9Y/0Q1yjKk/Jx65mNNOffJtVpZDZInfMU3hK+zrU+2xEqxS0HL0/O8S
         KlPpTxoqf/4vjrfMyXF1VwoIz/APhJdjlm+WGh+ukc2HK2a9NIQ3rVj3IncheCkPlwQf
         e5GNcydAHwnWf/+WOMeq9WuxI6fCK7Z70jmfpAALI1564AmWcehrjb9gp1kgHUEe8fjE
         /iNQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7yw+8TPqViY2RxDAPbejo9aXUYW48/KW7/jlFbfDpC2GTOAeHX8+HK0t+1YCPv/Fc7cpeaA/r+34=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu7FvQrVFLIvvnvqQugVZfCyYXYuYV9vf8DoKYlzZTqSDLVgZB
	4185WK0tTsVPqBe/Ng1GRiz+BfW47drAhx2ncyK1TmNfjiQAWiKemIaRWrqfxtO5vvcqf55x2ay
	XH+yqujs9TKdaqaP8dQNVYc8yQf0xK/MvcibwGEiwjRaq1vgmz97s3995k+UX06Qj3LSfTQA=
X-Gm-Gg: AYBFou3mEH8dmo85vp4Txx4q5xFr4BnTY6Aqb0oEAcxHphFC5k4nd9z66qWOj2dcpax
	YZxoyX1wFfNEmel1EEh4ny5KzfHchRCrR9bVciB/Tbw2ty/U8bqNTLhvb0A/JjNjv+XkCU+cTgn
	yYXbMm2SITt8YB2NOghTo+uBnH8xVKlH6UqpMHmudx4NpoE7VBDLacznmHP/VkexAJX3/GIBNQW
	aHP8pM3p1tvHp+bcOWFwyPfk/NDg6iNH4Hz3A2Q/NWflRiazZ64q6yACpVNtFm7kRFL/ExhxrC0
	1jGkPEUFOLdBj2srSVyHXdWJbGyw2qMdOOhY81fQ0ClatwuZhGSiSYtHvj21JKHjJ2ijEExuuMQ
	vOGfCUyjMQDET+Q==
X-Received: by 2002:a05:620a:601b:b0:939:a45b:76ee with SMTP id af79cd13be357-93ebd1dc726mr540212685a.23.1791583064871;
        Fri, 09 Oct 2026 14:57:44 -0700 (PDT)
X-Received: by 2002:a05:620a:601b:b0:939:a45b:76ee with SMTP id af79cd13be357-93ebd1dc726mr540209785a.23.1791583064320;
        Fri, 09 Oct 2026 14:57:44 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e48db03sm112130815e9.3.2026.10.09.14.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:57:42 -0700 (PDT)
Date: Fri, 9 Oct 2026 23:57:41 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Power off child devices on power-on failure
Message-ID: <asljVeRdLEkt939B@lore-desk>
References: <20260909-pwrtctl-power-on-rallback-v1-1-412ef996ba27@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kJ/5QrjWGDw70FKn"
Content-Disposition: inline
In-Reply-To: <20260909-pwrtctl-power-on-rallback-v1-1-412ef996ba27@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4NyBTYWx0ZWRfX4QEa9Kgo26qa
 LE7iDd6npFNSTBIyYyLlkRCIVJMLRg7OMBT9xbb8FB3RYpIUDueXoieVA+kBB6pS+G3fR2LAZ7G
 Sq4vuXrl8Tx3zSUH7XU+v+G8frmol1E=
X-Proofpoint-ORIG-GUID: zKDZxM5SCad9Rh0tvtSqs2mofV-xtZEd
X-Authority-Analysis: v=2.4 cv=D9jSufRj c=1 sm=1 tr=0 ts=6ac96359 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=zs4QwUBcvkXMlhRC2NIA:9 a=CjuIK1q_8ugA:10 a=_rcrTxMumW-VeXM4AMgA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: zKDZxM5SCad9Rh0tvtSqs2mofV-xtZEd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4NyBTYWx0ZWRfXwJathe97qu2l
 XRPQjkGkdEBpIGAdsx3C/x4ZXBIA6+0XLOgtw5Z/Z4c0t55ckf/Qz0mdK4XdzHL4Izkzjia0kNd
 /svBNSHNlnWJaHGE5k3Gq0FkQRTF3cb3ABeGiONaNCl4kRRnAEr9yHBzUoTxrG/Acgx3VeWd5AC
 C0+klxF1+5+38prw6AKCyJnIOlVSGDJTYDks8JfJpThn9l5fWRQa2qByoLn13IQnCd19FtiYI9j
 Vq5weER7FRZjrKsHv9vJzfmLxL5ekC7yZWN6DENgZTpvozRexlmoTm23ERZJLfDGzTTM25Qvq5Z
 6KT56jZUUJYyt7yfDnPevGfxD7T0+5qnu4Aeuwef4HhaDIKHvH7kax1HtMeR/EpwkbRNE0IwLf3
 peGy7aXA+gFvRacKtuXsh83b06nPoLINHgVwa2bjwn7Fux2L8RX+9dJytWmDZuHNpKY85Q0AOE+
 n7a0Ij/GpTK+YXa08Gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090087

--kJ/5QrjWGDw70FKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> pci_pwrctrl_power_on_device() recursively powers on the child nodes
> of a device before powering on the device itself. If powering on a
> child fails (e.g. returning -EPROBE_DEFER), the function returned
> immediately, leaving the sibling children that were already powered
> on in the same loop iteration enabled.
>=20
> Since probe deferral is a standard boot path, this leads to unbounded
> regulator and clock enable increments across retries. The error path
> in pci_pwrctrl_power_on_devices() only powers off the top-level
> children processed before the failing one and explicitly stops at it,
> so it can never clean up the siblings leaked deeper in the failed
> subtree.
>=20
> Power off the sibling children that were successfully powered on
> before a child fails, and power off all children if the device's own
> power_on() fails after its children were already enabled. Switch to a
> manual child iterator so the failing node can be tracked and its
> reference released in the error path.
>=20
> Fixes: b35cf3b6aa1e ("PCI/pwrctrl: Add APIs to power on/off pwrctrl devic=
es")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Hi all,

do you have any update about this fix? Thanks in advance.

Regards,
Lorenzo

> ---
>  drivers/pci/pwrctrl/core.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 10d817aefb09..d29cd506972d 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -252,14 +252,16 @@ static int __pci_pwrctrl_power_on_device(struct dev=
ice *dev)
>  static int pci_pwrctrl_power_on_device(struct device_node *np)
>  {
>  	struct platform_device *pdev;
> +	struct device_node *child;
>  	int ret =3D 0;
> =20
> -	for_each_available_child_of_node_scoped(np, child) {
> +	for_each_available_child_of_node(np, child) {
>  		ret =3D pci_pwrctrl_power_on_device(child);
>  		if (ret)
> -			return ret;
> +			goto err_power_off;
>  	}
> =20
> +	child =3D NULL;
>  	if (!pci_pwrctrl_is_required(np))
>  		return 0;
> =20
> @@ -279,6 +281,19 @@ static int pci_pwrctrl_power_on_device(struct device=
_node *np)
> =20
>  	platform_device_put(pdev);
> =20
> +	if (ret)
> +		goto err_power_off;
> +
> +	return 0;
> +
> +err_power_off:
> +	for_each_available_child_of_node_scoped(np, tmp) {
> +		if (tmp =3D=3D child)
> +			break;
> +		pci_pwrctrl_power_off_device(tmp);
> +	}
> +	of_node_put(child);
> +
>  	return ret;
>  }
> =20
>=20
> ---
> base-commit: 028f86457e822ab9de5b0d6d23efddc1b8b54ae1
> change-id: 20260908-pwrtctl-power-on-rallback-5c6364b080ce
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--kJ/5QrjWGDw70FKn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasljVQAKCRA6cBh0uS2t
rAPrAQD9OlESkDd1dm4j3CsPsBjECzdYY3GyZpK5kh82opae3gEAh7FUIV8nbpQ0
hQNaeAI9G4gZs8GUQ7b3oTC558+jpAw=
=Eg1I
-----END PGP SIGNATURE-----

--kJ/5QrjWGDw70FKn--
