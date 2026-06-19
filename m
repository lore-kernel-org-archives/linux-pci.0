Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4125742F
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854531; cv=pass; b=Qut1skC4QWT0WE2m82bhbnMWGATPpZ/WE0A3XW1MnZiYXBu+Nbtely7sR9FKbfmkYWiXJUgqZfvduk2HAXaKl68Itrbz+4pgS+++PZCOzs4UidP0P7PXK/jov89rlCzhpUOWZasDbIZrQXtxyADctN6TJEsSqLqboGtTDV1mYDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854531; c=relaxed/simple;
	bh=rvbHS8TEwc5H0jAG/iixPV9i8iJbTQilMvXCphn5wYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oX72KWg7BeE+NpgG2mLnzoMYPX99dXW3S9PVecibYHxTzxqeXidIw9oSFVauUjEs9Nx/roi2RGKZX5kVzhyehlxrYb8xdVehRlSbS7GiHu1qDE/hq3nx8Zd/lo+pxyRvdGo3ZaLOOGNQSL+6h8ZsL8G8JF9IiSkaaFzAWZE7kE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aJ6tcHFj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H1v6scES; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aJ6tcHFj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H1v6scES"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7RcYN082656
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 07:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mG6LE305nMwr4+PYe2o1WcOKPQkPvQ2hD8Sl+7mO15w=; b=aJ6tcHFj/BZS/R8E
	0+rb3ch+pyr6SwSW+s/w0ukwWTwHmfXNnX/SYkN5PM5VDGUTEAlEsZXGN0BmbzDR
	EhCMZeFYwxLpLq7YTcgYzfr+QboLus1UoJTnEwAVXpxyKLlBluzwXWlL4YgrvOB2
	RTmAU3yxtjLqHrreCRERuUmgq6/zIAu5pbb7RmihWdYlJg3VQZXXjJLsZZ6jhwmq
	n/10ZCPYcyl+qBVdZeQgBysmV2tIRZxQ/qNAoHQo6P5ZW5dLji+JI9cvOYizYS02
	8UXavz0i9RO41+kmHtwyEekJN5UxyRJ8lgUfBWwXmgvRR8kYNgrkq/4Y97W31yds
	XFp43A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmtjaqtm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 07:35:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-915c1997732so380302385a.3
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 00:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781854528; cv=none;
        d=google.com; s=arc-20240605;
        b=MfpfAosSqbCMhNPGrGJ+MzYrNuealUGJaYkcLGYCHL36CCNU/WqXIIuvK1wqLw6r2c
         702xYtJd6JbQJvOKPzej9hyV5jasIcqQJMbH+YHfIx/+mURfEICxkhDXduG1S4rQDOcW
         N+xzMoVU+4r1YxAFdjF9v8G4nUDLXUsA9UvK5ilOMJMU4a2CLKEsuUv+mZBnBfhnME6Q
         Zk1bF7fwniKDtSbEdvefabqq7RvNnJWjjU6XfyJ0P4l18/GKyCFX3MS6CSyamKr5SOLo
         UPgKDUX2MwOBb8ohqnXHLpzFfOPZFHa5TUB4ryK++6W1SFt+3AJzm4wJgdAwBNrxJRMa
         YPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mG6LE305nMwr4+PYe2o1WcOKPQkPvQ2hD8Sl+7mO15w=;
        fh=UlpndVphvP3EtBAcHbM5g9mEIUy1cP9e3t8tC1Vd/NU=;
        b=LQr6z0zLVxmRtXy9Rms8GSyyc311Vl19iOxe6aqRTtskR2QAiiSORGcevtoKApkz7W
         5qcbySpz/3/gXcz8FoJmPlsWedGMNWNjtlfUy8boPCvruShcdJ7Bykkezhu612AXqr+L
         HYbyUu5T41xsxj49wH4xwo88eYZcP6ZyqqY2WI4wjordF+Ihojnx1E1mPHGNl+sjrHgG
         YGoOTHMYbN1eaiHdI15ijWFVHsnDrcz8Jsv3z2EiBp+UflCZqFwJu2+N8GO3VOEHeFD4
         1Gyq/1U7SnR5dsxCR49vOPrLUpZegO+4ZjYnFgvaQUQaDMnyDUdXatqNiPZRg+fECi5q
         1LDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781854528; x=1782459328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mG6LE305nMwr4+PYe2o1WcOKPQkPvQ2hD8Sl+7mO15w=;
        b=H1v6scESHNXliGZ1VmEXy5VHH+pr7QQHSu056qP0uiWB/2rocQHxhObJRE3P4Gx044
         IJEDdcEtRru32AqxjIwF/Aj2ejj2Sls62YKaBUq3JN8BxwGS8CbMkMaT3+XWIxuTi8gs
         +tvWmp3QaIfU2bRL4p/1/Qub/ixFvnUQZhNWMVSbcxXs/CbYpGXT8ayPCRxgS9eNMnss
         0XGo1PQF53ncklVd6wDHY49XFtDUFD3nXaNIAYxxDJeU7k/uWJaF7dyf9kW5GzrclXSt
         A8YH099g/bfiU0K4FBX0Lj/Yt+otEj+4ujSNFEXfdUhD64v+lA8gOzNQ7SgnSfoq24ZH
         LebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781854528; x=1782459328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mG6LE305nMwr4+PYe2o1WcOKPQkPvQ2hD8Sl+7mO15w=;
        b=BFwunFS/SpAiajuUJ5/oTMu9nwanSUWi1UUkh1zOErxvfD5feVmhVM8cJYOJZcx+bB
         Pgk3hk3loLwdwcXrdqN6BLd2rv2yVHC8FQ3sTyOVP3rOyWZrbeZCyg3Hz6XwHzRvrWuS
         aEW6kI5yb00qWxnDXNPHH0VsdROB1ICcYnrqlgDBtGEXRHPNXzTWeGkFk+QCmV+zsjb7
         aOvg81U8WX9Itb9f6lqTG258pd0gwGem6jrYgrCdr2hVKS5XfGqEz45z2PceqEOpE4HV
         IkrGNTAKm/S4BZVoMVvV45RDsyZMMyM8RODO8y5rlCSoh0zdoZUG7VkVOw0GdRFhY2nY
         1AGw==
X-Forwarded-Encrypted: i=1; AFNElJ+UFaDNEv658xR6RBKCejk3tOZYI/07vtKOk1dhGj3MwkuQwmqKMZrXBCS4M8gr3UFwVwwXRY5vF0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlcTPBOAa1NGngSxnDXKMo5VPzVGgrGTVJo0q53IhbnKmPDTHo
	wI/mgUF4Hjl7yMcU01D+ntCc8fwPCTvCtnB+0Nrrut8RFS0EMQKWnyVxNDBfdEvExjcLr/s8zZ8
	8f1C6mKQO2O0VwLffSYfT8C0qKooZ1ZzT4f0r9e64q2PEJ4BhDglcY56trDl+rK9zegh28Yet/j
	SiGiTDwEhbi/IfVfL4oGWRiFPRKUhPdoJ4SuR/kjfwO5yslfHU
X-Gm-Gg: AfdE7cnjnpeACyUkZz23go9mkjjoGibp32ANhdApfLyGbtkaPnIAIhTap/++kLypztg
	DElK+uYAzqhjlKRlWqSc4KAnrPV+GN4j2zAND1IZAzulfduysvfGQ2MDxmh8+2RLZlwOCGWYvvJ
	J0LHCurmYfOr4Z1FnR5Jo1BEhJgiM89CwYpXvTdYiM8mRhfNFTQz/+u2pjcZrdePtWIpVCYTLuX
	6kuy5Tz7j7Pmer+n5bfreJBtYPuEoPEtLlBDchel5dD67ziuuFynGi/N7vN8JJezaGH7X/Wxz/7
	6nNEQvOSyQ==
X-Received: by 2002:a05:620a:84c6:b0:914:c0e8:224 with SMTP id af79cd13be357-92092d3ae2cmr372355085a.54.1781854528410;
        Fri, 19 Jun 2026 00:35:28 -0700 (PDT)
X-Received: by 2002:a05:620a:84c6:b0:914:c0e8:224 with SMTP id
 af79cd13be357-92092d3ae2cmr372352385a.54.1781854528047; Fri, 19 Jun 2026
 00:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618193030.69528-1-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20260618193030.69528-1-johannes.goede@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 09:35:16 +0200
X-Gm-Features: AVVi8CfbJ_rte5JQKGtAXBbdCfjL0bnY3mQOBTvWLCjebdT8iqd7a6Xozc7YGhI
Message-ID: <CAFEp6-2va6uTntquAaWjzVEeedAEbL0Dz43o5e-p526ZBU1sGQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add ACS quirk for Pericom PI7C9X2G304 switches [12d8:b304]
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA2OSBTYWx0ZWRfXwp1LGzJ50Pz2
 Fsa4FDRbQ7tu/r+OnQ4Stif8NIelI8AR9Ev7P2HcrecfywCnPsZwe/GsF55cq9Gm0pZIv3h5WiR
 ijJfq0cIyXgrxvuyHl3IfI7o9DAWbgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA2OSBTYWx0ZWRfX+DyqDORBjqeD
 6VnSrgT9AA2D41KIN+FgWjPmfhUoZJ+DELnIZRXkhQAMkaEzAQW889dCbwkKDk/2V3l4Wwncytr
 pT+dj2bh9y6DBeY59Q3c3TlBLMJQa2i8IiQRVwR741KcYWW7D1QZ4cfRR1/+wwiuFd+ERe3ArNq
 yUXaV9ugKvmv/+on1S+5zerr5mja7lDEkoVDR1YeN1HO0RTMH253S/uH7SgUMVH+aNhDueik3uw
 yBdvKQxERy941U8TmEZyp5qbgdNDgGyu7KCkEtZX5VNeZbZ+NzcntmVJbV++ddTpvsNAO4KQJfP
 UI4BYW41IptJSNzUejXoNzgTzgnXIIwn72eogwhnvTG5g+LidYaRWZpy59bmS4IyPjJf1wbbaEi
 bGmwJsYQQIkviYU5ZVqPTgBRfMYQreP9TEsMQIFyV92GvYnYiAq6xHD1DnJ5Rg+QtRKJd0fIkvx
 TVGnAHBPZgbHKIpcE+Q==
X-Proofpoint-GUID: PQqNhwkeZSWExHHwEk5am-G8sRL6QwwM
X-Proofpoint-ORIG-GUID: PQqNhwkeZSWExHHwEk5am-G8sRL6QwwM
X-Authority-Analysis: v=2.4 cv=OM8XGyaB c=1 sm=1 tr=0 ts=6a34f140 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=AaKoJ9VDXdoLbaRyV-EA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190069

On Thu, Jun 18, 2026 at 9:30=E2=80=AFPM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> According to the existing quirk the Pericom E5 errata for ACS P2P applies
> to PI7C9X2G404, PI7C9X2G304 and PI7C9X2G303 models.
>
> The Arduino Ventuno Q board has a PI7C9X2G304 switch (verified from chip
> markings) with a product-id of 0xb304. Add 12d8:b304 to the existing
> list of quirks for this erratum.
>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Confirmed with schematics and documentation.

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc0..2fd403ea3659 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6225,6 +6225,10 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x=
2303,
>                          pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2303,
>                          pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb304,
> +                        pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb304,
> +                        pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb404,
>                          pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
> --
> 2.47.3
>
