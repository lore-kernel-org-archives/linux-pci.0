Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCED4DB568
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333803; cv=none; b=GE/yQFHZB07nmWBFdpQrcCXZ41K03V/E0fHd18vfIsjcca3/E2329q10reDTtHOIiTTpmp/+Z0ZcCBEfhddI3dRWqcKRfpsbY1c2O/IuX4R7ni70CZCEM4Sg8y1TKwETSg6YbjhoPnT5SYWiApHDLcj7ExGHz1XYCCrxeVUQyM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333803; c=relaxed/simple;
	bh=QmLgSexPSDuaMklr6fTnA3PvfMhj8nIpwxXtH/H637E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/qWLlHcRT/PEyj847dsIkt8jTcEmXSnoJAyGG3ujY+G5zjM+0GOlD8+UKGouKajWPslP4NjaLCGDGh9YzmHm61UM5xb/NHkJvyHPRR75iJ1TM3BiSIWtIBySqCit9UOY2KAS/isxFnjUYRxPFS/zwMiyaGNC2FXeHNQUm/nvhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OAL9je9W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WPcs6tHT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OAL9je9W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WPcs6tHT"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TD8DJ73077174
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 14:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ujvd8GOIfYUMjRcKfMhwhrUy
	V9hWXOwPZ2H7jDD71XQ=; b=OAL9je9WOVjUmvQ5cVN3MtpxENNajJHA8Sny95dg
	NOtf0m14YapxC+4fD+f3JyKrjGTUeV9TfzO69xaGRg8GDHsw7bolIL4ZkexdUCEj
	IOZM2Jpy9yM811lKCQ7H5PUvwn8xplmuxJGoMamAmjHO10T10sJDZD2PGReqdV+b
	XiK0UpzDh0rbue1h6lXX3Pz7K01nVPUMcTrrht9F1RSTsvpk+JHypgJ0VMPATDf6
	54te2KsMTpmUfyuHvqqUkvgYitPftv6gksK/0QLdRgLdX++z4A6lA5y7JFghM16o
	U+vIUAwFqHLqEERc4bc3caAuXtWjJfEkfu5OffjNL79MBQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqh3mrgpb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 14:03:19 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7ec6685adabso1457694a34.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785333799; x=1785938599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ujvd8GOIfYUMjRcKfMhwhrUyV9hWXOwPZ2H7jDD71XQ=;
        b=WPcs6tHTgU0r1tumzchH/l7TYUJ+CG/BWgQYSoxL9ZdTOYHt2vGyRjtHeZK3lR+PZG
         lHK0AbQqi0hXq7pOKeHXJWnrNroU/hj0u9bnSpRKMcAl9EJQWVm5/HKNgVTRa7rgHWS4
         kezao13ASkhh/52/10ZLxtMjTlV9i+0kS6d5b2NCNJQozyZ4/6iWN0oQfZNCapRem8HH
         r3iaz3Fb7f30aVbdb5DEfXpT9ZliZv0dbPKd9cgUnj1SPprglBEr2e29GU6tb8nPbNVj
         FvdIaayMLiVRHt9jv1c9i4an9vJen5kHv1X8iIghrRsAAr5RvWaLBXB9fmJqbt0wuett
         3wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785333799; x=1785938599;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujvd8GOIfYUMjRcKfMhwhrUyV9hWXOwPZ2H7jDD71XQ=;
        b=BC8GCE2N3KzCrPatUtFUECI2KQc0KhXmOy4yW9Gk2eWkHJ+zjhDilMInKwnk3K0peX
         hJ3HBuynzcm6NLvUbCEJNLkCRAK6w6uZ2lt8KC6OHy1gcVUIxfmd8/R5fwWiC/sJCfKY
         lQ/nuvV3f74rMa3MaC3udUSLhqAM4FUfu5tNUgTGalEcXcN2s77QiP0urtrnIFdRb4+x
         Kicr/wICBIbqlOyT5HMCa+A/iNDhm1UyEN1ZK1RH7CmRS0172bz2aiqFuWQ9B2G4w9JB
         bVCf4mBHhR8QONJFpPUxCWM94CyEQhzwnNT1SFqJ7MVSUBV6axa66HBmK6jFLutrqrpX
         rW2g==
X-Gm-Message-State: AOJu0Yw23FOiC50K1P25Vi4xBSFjDBqDqG2qEeG0N4wiwvSHITdAAAif
	4xDBOIzS64zKcjKuUJ87MAA+8PAO6fTaNPpMtFa8TvFQ9Kwz6CO57ifP7LzwhX6nmMKhGC3x8sp
	O97xiMur9Lal6hCR/x5P1t9IfT45jyPlCONbgwiGlOjuW1sBEQ3covMWYR2gH1+vlb3l2WEc=
X-Gm-Gg: AR+sD11WYB0svkK9FYB00FL/ppRlbYa0NkPCN/wZ0d/C20/I8nzwKrRX+M8kJLSezAn
	g4eufgZVdS76X2jLh3ZdrOMVloFeemicVlIa/p6d4XiSYy6r5vdIQwePDKSLfticX09kfbOcT5k
	RyplbOCUM9TMza67mQlkPj5W2Vz0P1XzF+BMkqUb0DictPVf73+oqz4wF/fnkbx/J4M9sCUFLF6
	R8KupY7HqDUKji6I4UR/9cnNH6p7ECP3fE6+JfVtkIO28+cLaLU1f3M+e37JfOJY7VxE1EYL1of
	HkeJ16TQq/k/IuZpyENLWrKYnIEQgSPNBWK8FMtRJO7tcovu3c92CoK1uhN0hmJTeHWN2+EUWNP
	bJA52rzEK+C36LDg=
X-Received: by 2002:a05:6830:81ec:b0:7e6:da40:b7fa with SMTP id 46e09a7af769-7efff2c3b68mr3399723a34.24.1785333798862;
        Wed, 29 Jul 2026 07:03:18 -0700 (PDT)
X-Received: by 2002:a05:6830:81ec:b0:7e6:da40:b7fa with SMTP id 46e09a7af769-7efff2c3b68mr3399579a34.24.1785333797183;
        Wed, 29 Jul 2026 07:03:17 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83cdf452sm119986666b.14.2026.07.29.07.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:03:15 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:03:15 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/pwrctrl: tc9563: use devm-managed I2C dummy
 device allocation
Message-ID: <amoII3tD3wtqcH7q@lore-desk>
References: <20260729-pci-pwrctrl-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com>
 <20260729-pci-pwrctrl-tc956x-regmap-v1-2-20ce61a3ce12@oss.qualcomm.com>
 <20260729134401.8EAD31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z5q25nZ36hnRsEAF"
Content-Disposition: inline
In-Reply-To: <20260729134401.8EAD31F00A3A@smtp.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExNSBTYWx0ZWRfX1+wS9gkm+ycy
 wg/JJm126Kcg2F2MY0vKNlLAisjp9hSFSZqwrYR9iweKCBPPqrtBrcpJ9E5nq5SzCQu2TLjUNqO
 +yOSc4s3CkUS5p1FtMwfzDcrBwr/7rSO1OAkgsDt3O2VygD8aeGun4bbqb4/vUqZLigii36OR6p
 uIt42L7KWS5XcdA4++zdpPRdVTfsoboXBboGPyjy3apZ/qu+1BLBiVadalDyApR7KMBDTClCpvk
 pqrWgX3oZDYD7r3z4HwI9JDdUjzO/yPF/CVib9BzFaxfeEW7A4CbZmqWm+6tZdi+Q/QBY8UOWUa
 BUEkLQCrFtRJG+TEJH6s47JXk9TZWpP3W49Ec+ToGteovv8PNVU6iE8NDAayFhnOh7P7AZEpM9R
 cHwMTyQkV45o0E70nzXchEZ8sPlL51LJx13uz3BQGt+fqxH/Xw7ee0PLQTENo0TaePybXFgAHrD
 s4bmz71/jq8hj6dP5OQ==
X-Authority-Analysis: v=2.4 cv=F49nsKhN c=1 sm=1 tr=0 ts=6a6a0828 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=OCD42IZeh0mM_344py0A:9 a=wPNLvfGTeEIA:10
 a=KNR_7U3MQDS_PTxHe68A:9 a=EXS-LbY8YePsIyqnH6vw:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: KQnd06DIr4q-H-k9Z8shtE3CCHvUldHA
X-Proofpoint-ORIG-GUID: KQnd06DIr4q-H-k9Z8shtE3CCHvUldHA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExNSBTYWx0ZWRfX5+f+1lobHvdr
 mLL025SpFsynsphNq9tLroc+NON+ogKZ5UiZVK8lYdt7BOsri2hm7wSPWeay36LhtbsajiKhxil
 0VCxYcWqOQsohFPKwu0L0Cxpge9p2eI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290115

--Z5q25nZ36hnRsEAF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Use-After-Free due to teardown order inversion between i2c_put_a=
dapter() and devm-managed dummy client release.
> --
>=20
> --- Patch [2]: [PATCH 2/2] PCI/pwrctrl: tc9563: use devm-managed I2C dumm=
y device allocation ---
> commit f54ecfd3f2485cf33e559cd8f58fa24de337138b
> Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> PCI/pwrctrl: tc9563: use devm-managed I2C dummy device allocation
>=20
> This patch converts the driver to use devm_i2c_new_dummy_device to manage
> the I2C dummy client. It removes the manual i2c_unregister_device calls
> from the probe error path and the remove function.
>=20
> > diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwr=
ctrl/pci-pwrctrl-tc9563.c
> > index 8bccf3abd1892..5b05e76f6c80d 100644
> > --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> > +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> [ ... ]
> > @@ -607,7 +606,6 @@ static int tc9563_pwrctrl_probe(struct platform_dev=
ice *pdev)
> >  power_off:
> >  	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
> >  remove_i2c:
> > -	i2c_unregister_device(tc9563->client);
> >  	i2c_put_adapter(tc9563->adapter);
> >  	return ret;
> >  }
>=20
> [Severity: High]
> Will this cause a use-after-free by changing the teardown order?
>=20
> By switching to devm_i2c_new_dummy_device, the dummy client is now
> unregistered by devres cleanup, which executes after tc9563_pwrctrl_probe
> returns.=20
>=20
> Because i2c_put_adapter is still called manually before returning, the
> adapter reference is dropped before devres unregisters the dummy client. =
If
> dropping this reference allows the adapter to be freed concurrently, it w=
ould
> forcibly unregister all children. When devres later attempts to unregister
> the client, it would operate on an already-freed pointer.
>=20
> Could devm_add_action_or_reset be used to manage the i2c_put_adapter call
> so the teardown sequence happens in the correct reverse order?

IIUC i2c_put_adapter() does not unregister any i2c children device but just
decrements the adapter reference counting. I guess even if
devm_i2c_release_dummy() runs after i2c_put_adapter(), it will be safe. Agr=
ee?

>=20
> [ ... ]
> > @@ -619,7 +617,6 @@ static void tc9563_pwrctrl_remove(struct platform_d=
evice *pdev)
> >  					struct tc9563_pwrctrl, pwrctrl);
> > =20
> >  	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
> > -	i2c_unregister_device(tc9563->client);
> >  	i2c_put_adapter(tc9563->adapter);
> >  }
>=20
> [Severity: High]
> Does this also expose driver unbind to the same teardown order inversion?
>=20
> Since tc9563_pwrctrl_remove executes before devres cleanup, dropping the
> adapter reference here deterministically happens before the dummy client =
is
> unregistered.

ditto.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260729-pci-pwrctrl=
-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com?part=3D2

--Z5q25nZ36hnRsEAF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCamoIIwAKCRA6cBh0uS2t
rGtTAQCTr76gdQaUnAXCA1uq48BrHGvhSkHQUTWk5njmzBe+VwEA9BABDezLRN2z
vdmHy1276oBBfUKATOHbB4+8SzSyLAo=
=fdpK
-----END PGP SIGNATURE-----

--Z5q25nZ36hnRsEAF--
