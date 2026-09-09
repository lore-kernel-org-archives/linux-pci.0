Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A53914E0
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976473; cv=none; b=qoMepX7SCZJRgRk/MRUrRuR7SGzOvX8UuhEtH968G0ComHAPgYMx2O1KZQn5DLaYxGtH8iEPVDsj5ogskerLbP9n1AN/iBs3I/TKNESXAoq++1E7ENCg+sTf1tVrmfDruNBKXGWT7XX64m6Em/5P9eC6I6e2FkLJbpy/Tjp571Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976473; c=relaxed/simple;
	bh=p0zIvrq3rWWMpsFUIdxK1JTUvUraW8LebMqJXUniMZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FebSNsUBDe8cIzpyUeSePSKiZeZboWXG26zb+fV413jsjiBTDiTmSng7T9LWYMzS81Dn8rXjNXi/encpW+UDuG5kSdlbfNEjmZHh0B6+/5pxOKN9F+pIqTeb9+TZ6jyGXUP3i3rpYXPN8+alqIrpaq/YtBCxWeIJhoTUSN5OoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cfSmyUPW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LbTy6He7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cfSmyUPW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LbTy6He7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689H7YiN3133755
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 17:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gm+9IjBE9cdQ/0pMBuXgvhCeHwdA9Cjik6T73NaZKR8=; b=cfSmyUPWCvHVtyLu
	rz3IstZAvuTT/9o3NMA2V7wpZlhnhTyDMkensAM702lydzjPUNY/5MnMyBn+m+lU
	4do4aN1R7NvndsOueLhOgi7L9Jqun10CqXzzuVfslinBDtV+HM19c+g/CM5jHlNi
	oz4ZgsYrj3fkko46TF43drgpkXBXLE3MQCE/9H3Ared3JU+EgiveZOx6fOcSEzCt
	tE9Zd1gwdEV7s48UWJ3h34zi4OjNH9HsSn0Dmdd5cf8t9lsPyyDFtfsu/dcTTtsJ
	LfUuBFznsJ86c39+lHrRtGVMtUqpU8E7FgBoIALMcsi4QRbjVbL/Gk73ElfjxzZo
	hv410Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5ru22gf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 17:54:29 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca8aee88725so9662837a12.3
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 10:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788976468; x=1789581268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gm+9IjBE9cdQ/0pMBuXgvhCeHwdA9Cjik6T73NaZKR8=;
        b=LbTy6He7PG8Hy3SVCFYtgccsK61nx7HoqApyjhTePbx3PmCoQdEEgzj58jIsUTyGHG
         ip+zcL13F8Kg7gR/iGx5Ay+wY62KeV0sHcmAaG2n2+nCRAZinxpOwRDrW0g8byeK5gD4
         JNSysZPokGi1Y+pGXgEHy7h+UtcbFUxZRzmjMQcj1M9CsPxXkg+U6N5bFTaTcczxwLyy
         TwylA+zQtxswt+hQ++uw8OQgZ0WcYO7gqywVJFVOPg2sK5PeETCJBo1dI+5nVBYI9ojX
         +bYT0LHvzVckbqOtAK7ce8PJ/kOzc5MjO3oxxJRyvihA3uzMqxuH5zTeMScraX1yduNt
         7bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976468; x=1789581268;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gm+9IjBE9cdQ/0pMBuXgvhCeHwdA9Cjik6T73NaZKR8=;
        b=VczDlOL/qb10Gni8REW/W7Yf5t1LKtbA7mSvA3zTRPdO4nrF+9NdWgzxMYK0xgzwNY
         ZuG3sdS2NsBhMTETr1zD1ahHknk1SJOG/kVYJrLW33oQaqMBwh8qJtmRHRCp/wzcBPRJ
         p880CghrPPiGn5v6QYOsrGszgu082ON9+r3UiWJh2ilkW0WG7hPmxtOjEC/gMAybCO1p
         MJoc29XTQnlz3Fjm/BQkVBQrXeDXPr05jpK9RV1QkgfCFMVNJrsWxUODzEANq+VAPF+d
         vbh9L3O8XfgD4USv2PkQrRPQ1pDZtOfXBBaR2B58DY8x/TQBpvr96SblxR56Ce1HTZMh
         vEfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGtLSx0c0bCJ+n4rrOpl8hjbda4I6WbcD9gkXokAYOtsmuL+LGWyb7yudvy/rckMcn35AdKqHdH18=@vger.kernel.org
X-Gm-Message-State: AFuF++kJoz0cgfQAGAP0+6igXh2yMJU4sy9nveLoVCdexTDq1+9ANUCF
	8KiuruMFyYAumSz3bq5sEsRBz69ypmfn9TXm0D6ltdlFsr6j4cdr0S9TwadFWz0iXFhEQQeAm3D
	RGpmbFmB5P6drWv4NT1a8XLDB7UKgYBWubg2Vx8ehuyLxDOo8+iLZJyJVHFxMlus=
X-Gm-Gg: AYBFou2/mlNECOhGuF1Jd0RbPiORMq6tLConcGOtpcIr5CVa+sQSWtwOUWaYyv1Z2lL
	KSG90VEHpn9klhk6mT/h6HdPpHrRIoMy92HaGsdyRJHspKGLWxq04h3TcCiysW99kz3cRJn+aFB
	Was0TEeZJDPViCA5xk6a/3BFR1sH2DpptFmyb3wlCbVjPLsX2ttgEMhSV+ZIPaG5cXWUVk1evMZ
	PrFBuafw/QI0Fj2sVx5xGB8P93f0wus77r9s2/VLzzMd4p2ZpNi7tD4FzInufmjAkyM26Wylwzq
	ChPPadnSrnyoTiVSBxqnGFpXSmSORPfbin8Ehmq1qf/Xv4A6wn5sw4wuR0usMt5dNZfKl8H/2io
	YoseJwGrNHwptkXLST7e8Nf5tTeo=
X-Received: by 2002:a05:6a20:2d2c:b0:3d3:adad:f173 with SMTP id adf61e73a8af0-3dabb270ed0mr12635096637.21.1788976467481;
        Wed, 09 Sep 2026 10:54:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d2c:b0:3d3:adad:f173 with SMTP id adf61e73a8af0-3dabb270ed0mr12635021637.21.1788976466966;
        Wed, 09 Sep 2026 10:54:26 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm72009935eec.15.2026.09.09.10.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:54:26 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:54:20 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
        <kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
        <baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <skaestle@nvidia.com>,
        <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>, <bbiber@nvidia.com>,
        <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v3 06/13] iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for
 IOPF event
Message-ID: <20260909105420.00000abe@oss.qualcomm.com>
In-Reply-To: <apttObDR6jf0rvt+@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
	<9280aea7ae7197eca3f223ef5b998aa25afb29d6.1788222485.git.nicolinc@nvidia.com>
	<178846311317.1308030.4335813024474016483.b4-review@b4>
	<apttObDR6jf0rvt+@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M+997Sws c=1 sm=1 tr=0 ts=6aa19d55 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Ikd4Dj_1AAAA:8 a=9koHXFDKl-DiS4GoSb4A:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: IScpRgEKSKkXBgaOGzcnjPYhacE_LAHe
X-Proofpoint-ORIG-GUID: IScpRgEKSKkXBgaOGzcnjPYhacE_LAHe
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE5OSBTYWx0ZWRfX/ZquwoFzJxzP
 MrFF0aIEcQYArbLf8jbzl2Q/Kl48djmhC7pDWuRwyPZmWtjG40SZEj5inLJ4Lw7m+B0GYwG91aO
 xqbliZEbcAg1OP9XDYb4wUQUfpjVPtg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE5OSBTYWx0ZWRfX2+3UPMEx9ONt
 zUUAgDL2Oef6v7vrW5YBIcM3wVWRRJ1POwnhOyg4ldWmp9JbqwrXqB6JLjG+gXxXhDKNGda0pBd
 37VyJ4q+YBLMIrHlg3dEygR0vTxZCQ/K2CCU7zs+MRlRHLSjvEyR6olM4HwwQy4FMI0BONaQKgQ
 sCAevGdhtKMPpjuk75IcbIkppmHnrdI4ucDQ2r0GUzEL1Gf5JDUXfJkTMd7pXnAUogb/Et8E+Va
 93ZmI4G4K64XZWdPsqSrG3/wlnc7iJ9q9gaNQeivQwoIgQmaRn5YOAoPLzkQEo/Zw2ZPKtLibG/
 FPsaBgcipr8pmSRDXQ5qKvZEx6pzR+Fup6cquj0bGuKnxc1NXI9uKXWEI5IifgpabYyJBK+OtVO
 hEqg0aEQkkx1645q/IzwZO06GWavnyQ2nR5FgPft6gOkm5iZUtbSxgS1D/d9BYL4T8+bkSwqbjs
 Lb3yCwDiC9EJOL+/mgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090199

On Fri, 4 Sep 2026 18:15:37 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > > To handle IOMMU_FAULT_PAGE_REQ from the PRI queue, arm_smmu_page_response()
> > > must issue a CMDQ_OP_PRI_RESP back to the SMMU.
> > > 
> > > A stall event in the EVTQ and a PRI request in the PRIQ both surface to the
> > > IOPF infrastructure with fault.type == IOMMU_FAULT_PAGE_REQ. SMMUv3 forbids
> > > the Stall model on PCIe streams (PCIe must use Terminate), and PRI is only  
> > 
> > There are those systems that annoy some because they smell like PCIe
> > (present PCIe software interfaces) but aren't and use stall mode. However, it
> > is nonsense to use PRI with stall mode. So, instead I'd just argue that for
> > stall the fault handling is done synchronously from a device point of
> > view so a PRI request makes no sense rather htan associating this with
> > PCIe as such.  
> 
> I changed the paragraph to:
> 
> A stall event in the EVTQ and a PRI request in the PRIQ both surface to the
> IOPF infrastructure with fault.type == IOMMU_FAULT_PAGE_REQ. Yet, both two
> models are alternatives: a stalling master resolves a fault synchronously,
> holding the transaction until a CMDQ_OP_RESUME, so it has no reason to also
> issue a page request. A later change refuses PRI on a stall_enabled master,
> so the two will never co-occur. arm_smmu_page_response() can therefore key
> on the master state: CMDQ_OP_RESUME for stall_enabled, CMDQ_OP_PRI_RESP for
> pri_enabled, mapping IOMMU_PAGE_RESP_* to the PRI response codes.
> 
Nice.


