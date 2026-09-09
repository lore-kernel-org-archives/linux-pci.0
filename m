Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05FA279DB6
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976924; cv=none; b=g0eQ5k4l6NfrPXFLdI9qVxdmgK+GsNIz0PJfXVBguxXSpxu3RY3069wW9gm6k1RUtq5V/OlyL4yHvHSAB8bOQYgrwujG1BzG2j+PG+le2T90BOdPkVO566SmC/VVuPCEIlYkLwUyDBdO2T9dxJbbbhvmlC0MfCU7OZO3da7cYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976924; c=relaxed/simple;
	bh=y44p1I+qOxi8m4RJ0mcbujnCiDnKIlcRV/qr0KkL48Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ns9stp6k8PeINUNvhWbh3bBleSOfmNApRHRI1A9itKEtSxZxPpYMCBtSBib4Au4enrG0bIBBeDXb4TtysgZZ6qW7aROBce5TKypPl44a5STXvOaDfEAqhpc2KClh14YEB+psexCP3+dWmdMuVx0Ew8qubk28gsshNLhk16nAup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pzWzBtGf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CvM9aKkF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pzWzBtGf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CvM9aKkF"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689H7TFX2771661
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 18:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fSQi8KUPwQ7sewz9dZNSnIXQ06Hyg6lfMvkQJkpmQA0=; b=pzWzBtGf3uq63Kne
	EMslco6jUfhmRL0h1enVEuIQ+qX3dy4P6lulU1cMPrdfemPvte0EqEwNq+h3b8gF
	/tD/3r2bDdsf9RSxeTUbX9fviPxsr6un4RwlJmJCRM25QBym760LZOQRD9kQXE6j
	14wG2YFkf/DHYLF+QAaY6hEdM3PnvYXb4YEHndt1u8Fkg9IMa/3LTThJ2DBO/VnD
	7LtcidhuptVb2MWvaGtpgUt0l2zusLHvvkQiZu1HcARkwIzHkURyYSp2fKnlY09T
	f0DFrUYD5hvimJECNOO7knIJpQi4yCKt+olDX9iK0zwhC+uNhsZ5V/XU6Xxxnpyw
	p0QoOA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk62x9yba-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 18:02:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3965ba1ba3eso1606302a91.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788976921; x=1789581721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fSQi8KUPwQ7sewz9dZNSnIXQ06Hyg6lfMvkQJkpmQA0=;
        b=CvM9aKkFkkhzRcIWNiF2zXK1dlIuKdE8guZMYu61m6+g/hvppGWQWcutQtpHJdpIBc
         LGsIuSlwrP0gtUcxFacuT4uXOnj2Z5HwBT/KsF0M7qLnsBbIMPNk7LwxRrS8OgAXxRqF
         7kpUV1cRsZvgINGm69EEJ4ZAhYhTr8qKcmvy/RzVglqE1Iu9NxdbyGR1x2oUiNK8Qxyi
         74KO8bh6K+i7vDUU9N6Rl22n16In5cS2x7+b6OLolJX6I0bvTYwZm3z5OOotP0iI8a2F
         ij+StyTqt+kcg0LgwjodBqI7FzlY3cTRXdSxjP2fbJCIp69MM5C81NkvfdwWtL5qUzIr
         OHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976921; x=1789581721;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fSQi8KUPwQ7sewz9dZNSnIXQ06Hyg6lfMvkQJkpmQA0=;
        b=QWVdUQ5N1gMts1zTw2G18Bhpf+nqchE+Hjf+45XXCCHngzKOwgSpxQqAxNcO6+jb6a
         ntmGgAIbR+JrvSd4m8W/19ngAJVDot8+BC2Dqghx0NrTHxrnTLypz/R2jcx7fi+0tVOn
         dBsKErghxphigWP1jrHmWtr9s4Bcd2fGxjD6HGipE/seqDTYWrPHEGYV6MdJ7ZLf0RvO
         1LNYkDTjZm4AY6LtftL3JqfwVbow+aK5qUoe3a5o1B0ivyZPARVjJFJ8g75Mo3djBB+d
         rBtWa59MuOAt1vH6ES9Isqr1HFHv0ae22HkqST8g8L+yJZBq+YZ47p7nwJkbXRIveuKE
         6yrw==
X-Forwarded-Encrypted: i=1; AKwUvBxDoZtOdmcqI3CSDq7QyOaE7Jw8tVEqecATjey7qDeCcf+hqsNNp9Ox6R2bd34shlZkj40e4LkfGhc=@vger.kernel.org
X-Gm-Message-State: AFuF++nLo5sMB7WCjiEOqs8EXlGFQLwblzcTko3Eq+jxSp/2jkhN8o8x
	p6LxfY/oXByS7eqst2STOZ9Oqt6NCSQRJ8WOPlhKruuXRmNAc3wlIGvNSXrLQHY1pY85LC26RtE
	DQmwI2YqyUjWz+aqxOEh+PDbwCKtLurcYD54vpA5fuHhNRCyvgzxVbLkjQn6GpxM=
X-Gm-Gg: AYBFou17VeqaP8ZeesdQH6dR13O2NbmgDiLHOLd5OWZUmp85rRIRYjY9azs5Xq5zicY
	kfJywvtr7W9rgvkRuPJSGKjAwL9KDqAtenA85CPa1Jt7K0fR49gMmi4Kk4oKLUMfLxfsIch84jF
	K4MMN9wXwBmbmEvrBfMFsUV09sIVB0Xy2C4F3FFbQusPafUKr6dMiY0XlPEdeg8iRpcNkQuwnCW
	afaiqQqARwbi2huxWy1mYRtvRmvk0dAvoKoHcf1JKf0A6JP8vqJ/kyIkibsJhJ+iwKvtnvV66sg
	WLLpxuHkDbFPIWdzv09IWsmzhZRwwSKZLk9Nns/w7G62uWnPZKdvwA9xDGSVx1QSUw6n0ZHAAhL
	f4ad3BO6Pvp4na7J3bg5rj1l+rOE=
X-Received: by 2002:a17:90b:1d8c:b0:398:b46d:48c0 with SMTP id 98e67ed59e1d1-39d70baf4acmr2943101a91.18.1788976920448;
        Wed, 09 Sep 2026 11:02:00 -0700 (PDT)
X-Received: by 2002:a17:90b:1d8c:b0:398:b46d:48c0 with SMTP id 98e67ed59e1d1-39d70baf4acmr2942987a91.18.1788976919623;
        Wed, 09 Sep 2026 11:01:59 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm42727256c88.14.2026.09.09.11.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:01:58 -0700 (PDT)
Date: Wed, 9 Sep 2026 11:01:50 -0700
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
Subject: Re: [PATCH v3 09/13] iommu/arm-smmu-v3: Support PRI Page Request in
 arm_smmu_handle_ppr()
Message-ID: <20260909110150.00007bac@oss.qualcomm.com>
In-Reply-To: <apujyBWK+COCa3Ts@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
	<0fe5f381aae307045e4cab97f8000c575f34a9ee.1788222486.git.nicolinc@nvidia.com>
	<178846311318.1308030.15663048615954357081.b4-review@b4>
	<apujyBWK+COCa3Ts@nvidia.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIwMSBTYWx0ZWRfX64ksHpz+9THq
 2Q0bk0QI6bLkzn7N8qOFZAAHWNfSp6k+r1ETUxXuh0MlCutyg71Z7yil7AnvjCmgfzLpgKvchSX
 DkoXOyXu6wgh+XhnJaojjh2cT9atOUg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIwMSBTYWx0ZWRfX2/n3hgfMX87f
 TpSIEzsiIl4Rci1EexB7APH7LB6ApIHWPX4qhluE64r4kaEJGknhr0YaxMBUw1LPMq7d1QFXHfQ
 wtFKe+vNjP/aRRjBTzzMBB4xlQ+xWa46x8nszRMJcyRP2tz3jME6JroENPlBM0ysjVOL1LMsXUs
 /7sYWGBUjSaXKCO4Ada8KzTLZWZDswA/dVSOMbMcEtoqcYSN/5YW4VKYu38XK2Ib4M0j6bcKDhS
 08f5z2p+PKN8Ax9TCF9u0Jph6B513AslegicJNDQ3+YnhtzoIOeLTOHbe7Mnecg/t7/nMSM5Jvh
 H/H9oyNj3ivEL6/wDVHtzocg+sRsdM7l16mNIjKkJDHoKQRwxn6a1R0/XGgdKSQyb7ASUWs+Rsm
 pr4nRfEHa6rhCTcwVerHIGQUmCOj7lrQ4iwKCxnnhYoOqAIOjvTA2THLHGvwUrib0xUERZDDtd+
 d8QVSrAxSWOB/RhZkqQ==
X-Authority-Analysis: v=2.4 cv=UeFhjqSN c=1 sm=1 tr=0 ts=6aa19f19 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Ikd4Dj_1AAAA:8 a=LiRWeZnokV1jdayv_KMA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: C3Q2SBUSRi6xcVqTfSE6YckKwfKzmF62
X-Proofpoint-GUID: C3Q2SBUSRi6xcVqTfSE6YckKwfKzmF62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090201

On Fri, 4 Sep 2026 22:08:24 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > > For an unrecognised StreamID or a master without master->pri_enabled, fall
> > > through to the existing "unexpected PRI request" log + LAST-page DENY path
> > > to release the credit per the PCIe PRI spec. Merge its two info prints in  
> > 
> > Either don't bother mentioning pcie spec explicitly or expand that
> > to a useful reference - so section number, section title.  
> 
> Dropped:
> 
> For an unrecognised StreamID or a master without master->pri_enabled, fall
> through to the existing "unexpected PRI request" log + LAST-page DENY path.
> Merge its two info prints in the path into one single ratelimited line, as
> a malfunctioning device can spam unrecognised requests that will flood the
> kernel log.
> 
> > > On PRIQ overflow, partial requests stored via report_partial_fault() whose
> > > LAST-page entry was lost stay in iopf_param->partial. Drop them by calling
> > > iopf_queue_discard_partial(), matching intel-iommu's handling. Do it after
> > > the queue is fully drained, since the visible entries all precede the loss
> > > point: a group whose LAST-page entry is still in the queue gets assembled
> > > before the discard, rather than losing its stored partials to it. Nor can
> > > a new arrival race against the discard, since an active overflow inhibits
> > > new entries from being written to the PRI queue (IHI0070 8.1), up until a
> > > final CONS write acknowledges it.  
> > 
> > Kind of a general comment.  I'm guessing AI assisted heavily in these.
> > Whilst I haven't found much that definitely doesn't belong in a patch
> > description, they do end up rather more verbose than ideal.  Maybe
> > poke it to be more terse in English language choices at least?  
> 
> Well, some of the paragraphs in the commit messages turned out to be
> indeed verbose, compared to my original writings. One of the reasons
> was to justify against Sashiko that often nitpicks on a corner case,
> (which surprisingly works well).

*groan*  I understand that works and I guess this is the life we live in
now, but I wish it didn't give me more to read! :)

> 
> I broke it into parts; hope this might ease a bit:
> 
> On PRIQ overflow, partial requests stored via report_partial_fault() whose
> LAST-page entry was lost stay in iopf_param->partial. Drop them by calling
> iopf_queue_discard_partial(), matching intel-iommu's handling.
> 
> Do it only after the queue is fully drained, since the visible entries all
> precede the loss point: a group whose LAST-page entry is still in the queue
> gets assembled before the discard, rather than losing its stored partials
> to it.
> 
> Nothing can arrive in between, as an active overflow inhibits new entries
> from being written to the PRI queue until a final CONS write acknowledges
> it (IHI0070 8.1).
> 
This is fine.
Thanks

J
> Thanks
> Nicolin

