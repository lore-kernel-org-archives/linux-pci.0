Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E8388E7D
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584783; cv=none; b=Vrs21F2RZPNPiZ0tR7DYVMn/O+wIQDyNQumdJZYqqJzjItdxDclh9uGesdjoDuXSuXnZIikPxYr2VGf9q9P8pABTfXY/EDp56AyS1TMWYumpXEW+9s/5ikGOmyW0ph/mnHAqN3eefp8nTeSrPJGrJzfKCHtUCTqRZlJIL5ikVYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584783; c=relaxed/simple;
	bh=sw4ZYQUkSTfi2fUJscACJ/CQoJQ5XIsAIE9CStuEUTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlVkUcFnQTOxYtHsyIS6oB/RswruKrOjHrYiOMCTzXqSVUqqll67/PS1vkep9U7Bm2TXl+9z2E5omftKrUmeOwK3uoRTBApcvnPlw9gDnT46M+e/EUBfaImlpJnoeIvbK/yRAjEy/gzUrWjpHSept3QHLuLWqBP8yPppmOx6wDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R20WDevu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iwniuEWH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R20WDevu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iwniuEWH"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6695xt94929251
	for <linux-pci@vger.kernel.org>; Thu, 9 Jul 2026 08:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=b1d7ZhWs9f1
	sgfVpFc0YAcv2UrqZgyUhnYNnbfueP+Q=; b=R20WDevuhVIFqzclgrOp2Phy05C
	m1JVaAb/UgDNQdE5wCtzUBSXIqB/B1xmONzdPUBNSQ89ehj685Lv5gSStfmtQHl1
	dx85KmaDa8KDzv6I+6xXQBqEgOzN7SGTdAVWexjsgNRafanLQTPH7EPl9NOVZjcx
	0ZacKNr6GIUg++8T2RaLlvgQul6iFIpqNQ2LcLWF65nUzt3JWdxNaonaTxzJjBT/
	5JNCdx6zIu0XmJ4LAAop0av6v8zR7fiYSgK7Iu0rYt7ap1Zsy7saoyzBbQ/2izVS
	P6j43w1q/XN4DV7KbFQTc9nwsfYSlh87yEj4cpjXrRfA+QwslMJH5HxmA2A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa418gxsy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 08:13:01 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37dedbd1cf1so533194a91.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 01:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783584781; x=1784189581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1d7ZhWs9f1sgfVpFc0YAcv2UrqZgyUhnYNnbfueP+Q=;
        b=iwniuEWHOLXfGIH4WEvjEqTGBJkbvqMFVAhbAN657xFZh8JgFrmjAom/sUy9rdlc0k
         njnVe+VB0ptEYnnaJ15jlCz7xu5IoBDzC+iD2ST8tvHsbQ3n0lBlGW2XQ3ErdsnQyiMe
         8LMyghzHZG1QLVsPtxXdAKeQUHng0a7U5w0qN5W+17iMF08nT0NQc9qPw3oKNOx+AriE
         r6KJQSG6euJWmqokcV+0oawXqKs1zg7zVG9P1P/lFFjHmA65Rj3oI/i3bYM2N9K9DuXi
         TpFeNcqAL/u9UUwjHwNeBVtMYkBVPNH10l99G214Sq+lD0vRqsrjhSy+wK6WWXxGR22E
         93fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783584781; x=1784189581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b1d7ZhWs9f1sgfVpFc0YAcv2UrqZgyUhnYNnbfueP+Q=;
        b=YuV5rr5fdfBlaZCjMNWZUrPbK2TdVJUnsQ4+3qLQPDG7RPv+d5aKUNlOBhovEqCZn2
         93rJwo7qoR8XgTAVn9cc/iY1u6+FWj5auMMMAFMAELe+CrgziGmyX5DipsB6L8MPhagf
         rJSZkDyUSyFn5N4lggLYZQGdXxhkPQLuAke4CD2URHvlpbW68JlZisEuv0fE16Nc3899
         e99H+xGJGk7GgldqS+jU9XQnIm7fvdOPRpScYjFrCkieJ+CqRyb5Rek/68PMuOaf0JQ4
         ++7BfoONFPZ+pw36MuS7SdbtrFUqm6BRnElALIJ1YuJV5BNHRjahKzeOocU5XOWr9Ric
         JzFA==
X-Forwarded-Encrypted: i=1; AHgh+Rrn29MhUOq47wXIJoTrxYzYShIVhKtgfdQBy+AfNobljLTurHVyHW9MAWCeDTubrOle3hYEC1HqoL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjB72u9xGJ9N3oo1Qh6vhkv282gUInDLof+uoUM2bOHO50Cqz
	WetuJWbxulsQXl73Bf63tzDgfae+iqetfLdjtszhkGVx3Edi7+7xUgUwN0h2fdtDMK3zJl3Zv2K
	Obz40MR3R1AnNcOKAjy83r0AlR07Im2Yct1o41ROUX6dRhJmZOe4wvz9SifI98rc=
X-Gm-Gg: AfdE7cm19GhcHF314q+/lcXTSzbAzhy5RHWnofvG8pKjn0TJzzEcTeirrW+cuR8nUfL
	PaC2SVNpNDFDBs6EUkWIuOiQwNkameGZ93VPPPKFtBwfdS8FZrmIYSMDARMHUjYQgQUHGWEYsSw
	D5E5h/0MJWqc+fvgIi4E+kc/5U0lACMS4XTxkWDyK7wImejwU3/dtokXie5QshnKdSzUcBBrsBp
	T2sR5PBGY5xLJdQQoSAiz01I6zcByH1w23VrDUXw6akO6SUFiufkYAErDN3lY9OPgRHCDTewNOf
	CPhGo1UsnbS+WPWa7F20t01mu9YFdxkFGBbWETNqtf0N0XC6F8r12eSE+0flb5ItRFxjxVyFXOH
	lks4qnhQNK7csWUcqxD60VfzPqE9yJMvXIaBobB7u/7AI3kewkn4llZopmPQwoQ==
X-Received: by 2002:a17:90b:2f0c:b0:381:abcc:c8d8 with SMTP id 98e67ed59e1d1-38a1f1de21emr2603839a91.1.1783584780876;
        Thu, 09 Jul 2026 01:13:00 -0700 (PDT)
X-Received: by 2002:a17:90b:2f0c:b0:381:abcc:c8d8 with SMTP id 98e67ed59e1d1-38a1f1de21emr2603808a91.1.1783584780378;
        Thu, 09 Jul 2026 01:13:00 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506b48bsm774740a91.1.2026.07.09.01.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:13:00 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, mani@kernel.org,
        brgl@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe M.2 Key E connector
Date: Thu,  9 Jul 2026 13:42:54 +0530
Message-Id: <20260709081254.422145-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <vpsczyjw3ew4lhjwy6edzjomryna7ygyamgr5idw2aiq7al2lh@64to3cet3ufz>
References: <vpsczyjw3ew4lhjwy6edzjomryna7ygyamgr5idw2aiq7al2lh@64to3cet3ufz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UI3t2ify c=1 sm=1 tr=0 ts=6a4f580d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=eHU-EKddRagIODziGN8A:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3NyBTYWx0ZWRfX1fYGfoTr1rfx
 bd8Xkaj5aZdGzs9+1XMknMp58HneL0R7vBM0RNK3U6gtrmUWrtg/VdFtfTXItbfuPDnbNdtWFYr
 k16YyKhRl8puFR7nZlFIccVCzkKhSN7fD630LuW9cllzPNdifOCFHu4X3ID7lMrbHH513X6TNLk
 z+D42c3cdIDXOLEpDHKOOolSMNogEsyU5+jk3SxQheD459LG6kffGgv4itJwVo64RbDc1CKxJ+n
 iBrK9JLbrdmxo5bfGkeFPI5U5ZzTZ3Lnyha1EAliD/StPZ3+j8A1Ag/R+Vmz9NxGDt2JqinyvXN
 pqFlQbQTyIoXlJopa1Sph5r65e7k91ii1DCjaIG4GZpkpTMafX2CNOlNQRE2brvAUW/jhxt7EQf
 EmPNCYLQftW5C3s+8T7cV5rjQ/PZAn41IWsR0roCgYPVFBRmCuHA/kD5BUPPAxHF/G8P231dHTg
 tngy51UMgKyW35J9EWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3NyBTYWx0ZWRfX+1yCZAZthvEl
 3tVSmdsef/gDetGC9c4dRnJ5J+j2c02l6xcalagrxnha4tPokgDT9//HJKScCNkGgLtXG5ar/WP
 WiB+UCSlhngBUqRnI3hDAeVcTDfgKi8=
X-Proofpoint-GUID: XMgQL0bkxY5AxOacUHClBLQheE_VJ4IX
X-Proofpoint-ORIG-GUID: XMgQL0bkxY5AxOacUHClBLQheE_VJ4IX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090077

On Thu, 9 Jul 2026, Dmitry Baryshkov wrote:
> Separate, unrelated change?

Agreed, will split it into a separate commit in v2.

-- 
Best Regards,
Wei Deng
