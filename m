Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5863D79E2
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514351; cv=none; b=IBmGTy4wENZlj6H3fK0xMcgKS9wUghx1QuWJEZeUNnZsOiSlWNQqrdkTeAtL7rlojReLARn3Qux48jEzR8C1cJ5OrIzIxfKgb3OddtvoQOsj0D43+wcCfB/QUQGBZpoCNHoWykf+nXi7tjqXBcFCyfw+gGzLV/ORwvK2mRF2/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514351; c=relaxed/simple;
	bh=LB2WtpgONiLQ7gm4vgAWhynn32lwn8w7mumONl9R1DE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpNYNVD13Y0Bq9vU0prBvyzJk3AxYf9UTKGHXjV5dUONuWTyQ6wzuF98I/W21Mb/JAbxT1uKPxtkFoM9RIMAIX2Va9x1nFdqrypMcllVd5D3U3wQ5IUUGE5RrU+NCeSBtMswGmlESYD18MNIBOPFESRs3jB0LYDVXQJsoiCXhmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k/QXEAJZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N7IqOwBO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k/QXEAJZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N7IqOwBO"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLYY2q050481
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 23:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GtfgcKKZ9v2ZBngMs3bfVx7nttoh7eLy//n2NDiu6Fs=; b=k/QXEAJZPF8o0hbe
	zJKDfE96pVBa6P6bbffHXgxPf8ByvvwCNLbQnT8jOezZGipe4pQSNCGmZX6SRja8
	s/9qSA3W+q10+k0RWG6A1fN7nTsXKcU7JJTQK8pJfgEic5IZceBfiq/G7j6jw4Pl
	qEI1MTMbuUDn0PJ05QNcU2Mi8jlC0Zoc9UhECS73gMVHhyBVerUWFJPQASwRjnvq
	NScXnu5WeM/LgfqcvMDPKyDNt9/T55bqjZ+k+djBfWZDep2JIUzDzKpCYkRxsXTi
	dkTVzF+P5nstaHlgNeZqW7wrKLfy/uLQa0i3+5pealS2Iu7hagzVSugToGtCx19l
	IGD4Kg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq9n61qed-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 23:19:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e18af9f48so742348a91.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789514347; x=1790119147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GtfgcKKZ9v2ZBngMs3bfVx7nttoh7eLy//n2NDiu6Fs=;
        b=N7IqOwBO1Qwkr6StMrDXcuSSlWQsnVPY0UGZ4Wdqv5sRHFllzUO9erQvSXnJ+TSFRO
         XVRRJ3XA+VJ6zDwQbvpMHHaxUhBDQKBxUD6uK5SpQRRgcZzjxHygcomwMxjwmSBYZXpM
         jA0HAATNqxaPpBIfvJNMbNe59qLMLr58oavwv8gi387lC58A7eZxyGqmR6e6sjySV9D5
         AgIQZy9l46SZ2oRaBOCJ1y1rGojPljU6towen70mzyQkiV/o7MB5GCwYDl7vDeD6jOZr
         wVHdymRH1TtaQD49eY74BLpKauyB5KS5qfHfjLf+FbNcF2swXcjbJBQ8KAY/Hft9IiEg
         md3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789514347; x=1790119147;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GtfgcKKZ9v2ZBngMs3bfVx7nttoh7eLy//n2NDiu6Fs=;
        b=Xknj9LdCR1mP0EPrPL3a1A3Guht5yj2jD9BXX0oNSCp+d+DfdmqiItU0iMntghUja8
         bmaXsZAyi2PCeohqaEC465BxVQAAVstlizIwhPvsneX1kfIf1Dimci1jsXyohWN3GG2z
         zcBOb33cTlEgyMsuDT3vTFbLinfa9kuRcUTu83ZCvo9t50LrgS0GLs2JSjIG4LZ5gPGO
         Hes59IoG0uZJh88mjtasdOxlBPHEAqwKbenXakcORSJkBB4ZQYhOnU6nhLz6CZ2eHix2
         hhl9X//o+8ftQCZag9kWXpAVyygLGiKHUbHm4lnjd5p2d85rHsBKATKX40iGdx5eDadK
         bH+g==
X-Forwarded-Encrypted: i=1; AKwUvByvRgu1/pktUQW/xqZyHhj899V8qqNyJD8VFu3aMt3dI5GynvApI/IbrDswR9LB//uYCtFRyvXGcnY=@vger.kernel.org
X-Gm-Message-State: AFuF++mfes6SwxacIX+uPeQpa3btODiqrXQCy6iReNSHbN8aDujcTsEp
	5OBgtNeyoVMDsE9b6N60D9771/nmZcCBhgnY/lNGGpff+0losmIBiqGvMUuFoqHH3noX1/isoqi
	bu0vWSOSB/g0Y6h/qGp6Qn9VmsXdJEwblziEs3HIaYTS+LY1l2/oNgUCk78o+OlLlkcx3o70=
X-Gm-Gg: AYBFou0xUIPpXaO6IXkwsBKi9Oby5mW4GAPstdCnytzlP5m6xHeSsiDQbyO4Cs/ilsc
	KsaAFwmDKRVruveq/RusjSFeztTAMSX+I/LkBvnOUdiIv8RN7yuTm723F9kUiGviL+qqIb/Pr8/
	r+snUn5qwCiVgm1gyexS6CX29LaUZ5TkPib70XILn51uk6fnm1gvWLnckkZmC3EwE5Usl+LHivG
	7AA/H0w7Z7HM5qwExvlmZF893E4Hm8OKdPFtBjmc5JCh1F+w8moCJBLyJDchDV8ZWVldvcP2JSU
	L6JjniTHqqlNEwayPBWCyI8HOlYnDIv5rY7TDqsAjZaKLadaYhnqIisfIap+wrzTSXpQJDxzyIU
	tlXbXQljVz5zJ8kdVY+KazXhY3sU=
X-Received: by 2002:a17:90b:398d:b0:39d:ec1f:b3fd with SMTP id 98e67ed59e1d1-39dfe036be1mr8656432a91.8.1789514346881;
        Tue, 15 Sep 2026 16:19:06 -0700 (PDT)
X-Received: by 2002:a17:90b:398d:b0:39d:ec1f:b3fd with SMTP id 98e67ed59e1d1-39dfe036be1mr8656394a91.8.1789514346415;
        Tue, 15 Sep 2026 16:19:06 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a175sm2279027eec.9.2026.09.15.16.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:19:06 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:19:02 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
        <kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
        <baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>,
        "Eric
 Auger" <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
        <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v5 03/15] iommu/arm-smmu-v3: Add Q_POS() macro
Message-ID: <20260915161902.00006cd1@oss.qualcomm.com>
In-Reply-To: <1db9d32df4a59dcac286e7a82bc2704cdd69b8e0.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
	<1db9d32df4a59dcac286e7a82bc2704cdd69b8e0.1789446520.git.nicolinc@nvidia.com>
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
X-Authority-Analysis: v=2.4 cv=BdVNQbt2 c=1 sm=1 tr=0 ts=6aa9d26b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=39RnTaQb96y4xN-8A7QA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDM0MSBTYWx0ZWRfX5YBIy5cWIMKi
 XVmsQmeLP2WuV6xonYVv96GD88VCZaeuHowf3CtCjOAQXwSrFWSzKVjzxwpCGKMPAuzbvLVAihE
 qctZK7hru+cytv7FiVqcD4Z0HKjUykHVw4SHHgoZo+PbKBK/5EB0+d9qRED+/MtH9BHg/92PaBS
 SQTPcvHlgTmulatGgpDNpsUnkTqn9om2ENTqa796fjvsNF6hnFE8Rc0ji8Kl0zN7rPlxBpAue0U
 Xl1ChUwhWie0Cbtsb5B0XKQY7bC1R5jdNk4mGsdiwdgt2njVJ1KTLwtGKsfRu+4+cCWxF8Jh1q5
 gAPjEJ2Nha88auey2syYdt+GSTrdqMNmroaI5MoRRZlkEfKTr8zMh3cUK6MdsKKkw0rrhmxae1G
 GXkk3pN6DkLh292uTYqjXg9GPhtA1SvQc0LjP1HCJioZrycdsP0CtuK41PNiMVmjut+HODqS7sa
 RWbEtG7G2rvYK1Np6hg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDM0MSBTYWx0ZWRfXx9CpNBRJP4iB
 34AuoJ539iFraOYGa8WLALH5L45qKPy9uu2ptTAQFouQCkJqBkro0ok1i+jl1yH59oLymP6FEqj
 V9Rrg4ML5eTQRZJoX1ShaTyIKuAk4/U=
X-Proofpoint-GUID: zXHnxtjOzJklvE5SXVArYsSEgpD7dkyN
X-Proofpoint-ORIG-GUID: zXHnxtjOzJklvE5SXVArYsSEgpD7dkyN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150341

On Tue, 15 Sep 2026 09:38:15 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> A queue position, the wrap bit combined with the index, is Q_WRP | Q_IDX.
> It is a (max_n_shift + 1)-bit value that wraps at twice the queue capacity.
> queue_inc_cons(), queue_sync_cons_ovf(), and queue_inc_prod_n() currently
> compute such positions by open-coding the two macros at each call site.
> 
> Add a Q_POS() macro and switch the open-coded sites to it.
> 
> A subsequent change will build a Q_DIFF() on it, to count the entries that
> a queue pointer moved past.
> 
> No functional change intended.
> 
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
