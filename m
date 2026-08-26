Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA073B7751
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731770; cv=none; b=phPwtw8z5uay/UFWY/c1aSmw81ihaw94PFOKhsofOl6e+SmbrnYLNkFIT/fM0EqUT/mu8QO7I323MRLzDo3099WP+Svy4xZpzHtdedORifD0YyVURUTqD3oKadKe5r10JJE1pkdA1pafwh7JBFM3U7nmnbo4nj50CIhaoo3Pa+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731770; c=relaxed/simple;
	bh=rEbNkFigjp0FGDCJsty0si0XKQ+e9anzsk0sFIsDhoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOu5iIdDNT3gKLIeTxUWeaBsm996+4M4laFgzrRiccHgeEmDcjH+MwH/v78fQl3YNUt1Q7nAnLdAICK0l/a7pmZDTkl+urIJh3xNxj3hk7bqpm/5Kxvphto5TfK2U6zbawutLvbWdC1MDYoajSEi4qjMOJUkqvmOL0g0wYooSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YuQ1hN9N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EesU6/Ck; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YuQ1hN9N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EesU6/Ck"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6Rc9J105940
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OJXQT0c6OYFN2aHcq1lc8qaGVj0md3a70HDIO/2Fy+0=; b=YuQ1hN9NkB+j/f2K
	jM4IdS4G+UxnMIRU84VU68/00IK/Or+kzo4uaBrPFYs+NqjhdZ3MONsOrl1mXxAV
	Dwj/k1yXeXte7091lspDKCgublXsw+jOBMltcaZFLiUxA+xJ9cghEBkD6925xiAw
	N01RVw4hEZlasO1juIDloEqq5SAL1aC0P2DqultRwCzLNHDq0UH+IKYpsxjfgT2L
	BHGYYkD58l2QL0GpcEDWFPz0giEt7t4wAXs23Ej/tn6kfPB2Y7Ngp+Volbb1PHl4
	bI0WpaxoBUjUO4+HrOIgYSZKTC9LERCexEGDfXVwjKm4JelbNEFSrSYxdjkaFRzM
	HmuAjg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k137p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:09:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0408254aso22077291cf.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 01:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787731766; x=1788336566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OJXQT0c6OYFN2aHcq1lc8qaGVj0md3a70HDIO/2Fy+0=;
        b=EesU6/CkhAShe5PRTIpIMtJ2EBGbKbyHgadTLRkeuz92p10et/KS2G4evShrQJ2ku3
         N5ZbmM4jlP03LgKr6fQs2HGhqg06lvPdERZI0MQGVb3XxFpVpKPxg5S/WkG5AkSvRl9v
         Pzq7BldSswNrmgs5QfVZoBCrR+HbdrbF6ApUvfr6UxyE83sW7QKd7DVNQwldCF5AwdL0
         gFVdNbram0CmziAySg0BJ49YCDIWtWKRDZSiFwP46vPZoG32d+Smu0zDMR5NBQtCjsct
         l2mYWM4saXam+j9LkjaTQIF8crimRdG26FrGnc39y5bxS257rJThH9yEIuuFFvz26QDg
         hMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731766; x=1788336566;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OJXQT0c6OYFN2aHcq1lc8qaGVj0md3a70HDIO/2Fy+0=;
        b=Z3d6h+4w50fyK1M4M+ShzYunKfnR9EHTr3wjL7wXVO/xlbqyAOBpAbEZLu/jwfpAih
         Z23l2rGQCog9+cJ4kV0TDeJWTGdAeexveO8e9wyC8seD1pfqoapNWP8Z+qkgARvlvUj+
         txjxnQAbab2+jg4FyjkdW+JHg0ABkRVqtLJd8olYNceIU/RabaNwXH35MJOqJHoCIKK6
         AHw4f7pajZbrh9/Ep1eKrwWjPfPgZxY3ZDAgAR44SuWMVzYry+wMm33+UeU1GS85wA3r
         0kbg7ke9/g2FQJt85eBgr/C4FFwY+xNW2JxLz8hDFo1ec3oMI9rqQo8UunjJu7tGPWO3
         78Gg==
X-Forwarded-Encrypted: i=1; AHgh+RpG/WUUU+/k5MOhBOXRAcL/p9CK/GOmhVQRbP5i0ZrgeEyV0yOycUFIIQ48b5q6eqV1mW1oKR2CkeI=@vger.kernel.org
X-Gm-Message-State: AFuF++mlMb7HeCyhAOY1HJuLKUsl96WQMICdXvjDMmGEkWX/jJD6WBoB
	TY87SuaJDsdj9Fo3xEvHnEy1Y1A1DZxbh5PCurDIEokmDqDdU7ppwbdKSv6NNB/zGKI6uxqfkQY
	ZwGC2jposX9SXG6ZmmVYhwQKbjysGoTe57syCcpqzqWpZzaNyxf+kadp8KLIyv3A=
X-Gm-Gg: AR+sD11/HP+KWFgVGQcwzWjZz+5aMqM3b1SAQtiarUX9b/FlhMTDG6/3eU7NlLQNQ5K
	gVz7gfzUBfWKN2LM9pGMHxK3Cnvtyg4dxEVJJzu6CMXyk1ycej85Co8UoeL13X1U9ZdUivOAtCi
	VmW5+k+V5dT0xRpvHZwvc+YVWUKwq39dKETDagByr8CsmREhGczr7K8vg8dD7toY8qutJpiSpzO
	IrQn/ElyMw1JlzN04HTSsA3yS8P98vDHt2p7mEL4dwgfQNOXgFL2rme8G7kchJPWOHT6E4f37Fw
	YyFOx2R4QLu+AvZbIysdUb9sDWxe9hetc7pOL1aMoRv3mZtAkjhCqEgfuislShFxDlh9Sc6K5rT
	fwcMCTSNUoFJb8EgvNWED76BjUzF1
X-Received: by 2002:a05:622a:cc:b0:516:82e2:7788 with SMTP id d75a77b69052e-52e2ec1e3c5mr116721411cf.1.1787731766302;
        Wed, 26 Aug 2026 01:09:26 -0700 (PDT)
X-Received: by 2002:a05:622a:cc:b0:516:82e2:7788 with SMTP id d75a77b69052e-52e2ec1e3c5mr116721221cf.1.1787731765865;
        Wed, 26 Aug 2026 01:09:25 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dfd4:a0a3:2df2:7724])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dc96bff9sm18773245e9.5.2026.08.26.01.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:09:24 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alessio Belle <alessio.belle@imgtec.com>,
        Luigi Santivetti <luigi.santivetti@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jeff Johnson <jjohnson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, imagination@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pci@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v3] power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable()
Date: Wed, 26 Aug 2026 10:09:22 +0200
Message-ID: <178773176015.26343.5524450275043262993.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
References: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8e9f37 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_EivlD1RsPJwtJxW0JgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2NiBTYWx0ZWRfX3msAeAYD+LrJ
 L2+aBNnC1O31e/SXsX/b3xvsMhRqiGHeypk42T5EIPRwz98tDUp4d7U29mthInDOphsG0O+BHGu
 idFsVFiyvplfaMjmjtNktmokthdXV7Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2NiBTYWx0ZWRfX8wrTe7Rz1agG
 eAYWtW+ysu4shhwfOryEc0DO2/miTBzK3Q0rSLDd5QMzJsnWto1xrF4xEpuOyJbEmkpMcE1yW8q
 Ar4zZGgKEDaoQlh1LTduhUV8K+g1Vybz78ki71fRbxV9xAHvlOQgH4+nlTdHWFyzl6aXh+laz66
 hm3EOyblNTSm/OAx5Q29AEQRjsMfjixsrHd8IKjn1ne3GBxNEzt2ZBkUD7EHhjGcN6Q0H7WGplh
 PgVHtblliWrJtccVlv7WPaZnN+QXEGEXp+75MDdBTKJ6lPyPUTvGmzJgbcF2MELCylpNbJHfc0v
 IoCjFRCDB9gYYICcBNjXcDz33lzU4IvhuO7y9tAS46Syc78kJjEcGyDpxZr/W0QXm4OsUUN9Ww+
 NZKMiJkY01lFmoZQGOui40ux0o5+7ppMytQA6/VeF8EbocCaDZrNEhv71Gao/B87izppOoLw6RI
 VBroCgRIOJFE+i1rYCQ==
X-Proofpoint-ORIG-GUID: SxLUfz6HLksGx2yHvodAjVysMH-1ytao
X-Proofpoint-GUID: SxLUfz6HLksGx2yHvodAjVysMH-1ytao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260066


On Fri, 31 Jul 2026 15:42:18 +0200, Bartosz Golaszewski wrote:
> The way power sequencing works means that a call to pwrseq_power_on()
> does not necessarily result in the pwrseq target being powered-on at
> that time: it may have already been powered on before. Similarly: a call
> to pwrseq_power_off() does not have to result in an actual powering off
> of resources: there may still be other users that requested a power-on
> before.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable()
      https://git.kernel.org/brgl/c/d51fc9d4cd6eb18ac82913d83ecf7bd8c85f71ee

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
