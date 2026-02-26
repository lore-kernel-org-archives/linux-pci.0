Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1640314D15;
	Thu, 26 Feb 2026 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098629; cv=none; b=em0P4o8niEBP/oBg+4PMDiUTkd+eLZVn3FeSbdRkdRci4YqBG9hhfLaok9E+++8nJqTMipJcLNMrpy4niW+R/TlyxfHraQ25uZgqkgzxwR7ZYIKlOeluagiX4fEa9Sp/E3Q3qBDk9m85GxfXA9L3hCZd1w+B4E6/CdynH+a1w8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098629; c=relaxed/simple;
	bh=H6GZiImvNP0gAy6tyvxgg+R5ARJ5SpM+azXA7QuHdhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/EqLZkoyC8dAR/YO6TUj5OJ2C3YpCRnscf1b8ElIjFN9NHIzCjrUpysU/MdACoOsqCKKU289yp3eAsSoedyck7Bah4vCixz/NI39Nxdv36B7xlU+N2iiOvYo6Rmi89AIvcldkl7Yv+cIYD4nPWnrT9BlvJyqtOk+/7YF4DXBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JtldNkl8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JtldNkl8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNK3pR3519625;
	Thu, 26 Feb 2026 09:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=znsqjWpdh2QklVYbeWYpph8yYSRcfRYvBWqRy+n3mKs=; b=JtldNkl8eHs4
	2FzQC+YuKFJm+1PF00N6efaNSkvdp2wf4ivapmzWjCQLlwzG538oLNEA0rF/Ceen
	qDBtmHao9vCQgv5n0zw5KjFIUdehykkMfGtq8rMMnlfjQNxJ4a0IrmRoAegAm9o9
	iXgvm1qManQKtIdVf5QHTNGOwyd5kSPr8JlDeHiMgpRWEhxtHIikRLuaiexTlX9B
	WKqySLl/RxDCpcLpr+2NgsGgVXHB+OcX0XEO8URZ/+Aa0aG8lUfsXAeIEHhtsFNL
	+8MqsxkovrhAcaAUPMImqYQ4tfMywAVFbGC49Ge+XbkyxTbsn561KyXQWxbiFNFp
	GkWTHdrNWw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4725jfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 09:37:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q6drOZ015750;
	Thu, 26 Feb 2026 09:37:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1stj7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 09:37:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61Q9avZr48103764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 09:36:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C80432004D;
	Thu, 26 Feb 2026 09:36:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5C422004B;
	Thu, 26 Feb 2026 09:36:57 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 26 Feb 2026 09:36:57 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vvXnl-00000000QGz-1uhY;
	Thu, 26 Feb 2026 10:36:57 +0100
Date: Thu, 26 Feb 2026 10:36:57 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: ionut.nechita@windriver.com
Cc: bhelgaas@google.com, helgaas@kernel.org, sebott@linux.ibm.com,
        schnelle@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 0/1] PCI/IOV: Add reentrant locking in
 sriov_add_vfs/sriov_del_vfs
Message-ID: <20260226093657.GA47077@p1gen4-pw042f0m>
References: <20260225202434.18737-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225202434.18737-1-ionut.nechita@windriver.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: d8MjlFZH7UB5Sux_-LAI0kLb5rBZ6i3w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA4MiBTYWx0ZWRfXwN3fzUfAicJt
 fIkCQEcmCmT1YqWw7gWmy4emosNFyblCP9hQbprZoyKpp0WS1hU9ZTMbkwk9TyQoRQnm97ehCRR
 00ZeWgXDvYso1IVg8lIVvtm15gaUtF7HdkXfdU7Jg9LA7PPThWIvVJfoz+Y1st7GnhKGl74HulA
 SONY1OmcY0nIOIi9GsaFq5rzLsWwiiW8viWSk+Vnl4pzI8jPexWD3fR3ZtkEzj0PiKWc+sMPbaR
 eXq0L1wg0niobXfZp0tfY0/xBVItOz8RXaESqaoLVV22YpxUV4xYKa6wXEhx38KlRP5hame5kte
 UjUlWBYCA8jeZ0LmgFhHrLS2t3GGVih0FO4FOqPnq6r/LQEnUx45wwRAGWezFu6sTxnmY096efd
 Z7Z+BuB4pqSBcLKotKsVjqk0PBXs6be1XEJ9+YRZb2N1x7W8WYEh5mzg80IfakIUKtgdcEAwvsM
 AEr785pfAtJVYxWshSQ==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=69a01441 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=t7CeM3EgAAAA:8 a=Um52qBV4cRY_e17fMekA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: -c_u1tUD_uOs79revI-QwVmvAD6QTi5O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260082

Hey Ionut,

On Wed, Feb 25, 2026 at 10:24:33PM +0200, ionut.nechita@windriver.com wrote:
> This is v3 of the patch adding owner-tracked reentrant locking for
> pci_rescan_remove_lock in sriov_add_vfs() and sriov_del_vfs(), to
> serialize VF addition/removal against concurrent hotplug events
> (including platform-generated events on s390) without deadlocking
> on paths that already hold the lock.
> 
> Rebased on linux-next (next-20260225).
> 
> No code changes from v2. Only added collected tags.
> 
> Changes in v3:
>  - Rebased on linux-next (next-20260225)
>  - Added Tested-by from Dragos Tatulea (NVIDIA)
>  - Added Reviewed-by from Benjamin Block (IBM)

I am reviewing/testing the patch, but I have not given you my Reviewed-by yet.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
