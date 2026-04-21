Received: from smtp-out2-05.simnet.is (smtp-out2-05.simnet.is [194.105.231.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125331E838
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.231.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794565; cv=none; b=edbC6xahmMasUQlZtw4hUFbQvrsbb7xU4ujytQGPwMx8GBzi6r7T9zezIZTDaL+cbNRe4k2j7LSyx0hQl1wwW1F4uMs7Q0DPxcaNvW4c+nuywlToPnn3G++ff+QtVHe2fxBjZKhQIYbOwAMrtnaJZ3ylBo3rjckZlRYbgYTMfb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794565; c=relaxed/simple;
	bh=SgwPpwOHCh0Yz/dCwB8g2U8wr51fqr5nosYV3ck14Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ah8BP/CFYo9BuzCuE3UX1cBFqLSB19c0H/mg0WF0HIMnclvmcqLY3QVCFUzsMNDDv1rktr/EltWOHqpYk+0d8aiP2AYbZToO3IKe8wMeuQ4eBR1R2D30Qs+ibo0xMiFxxzQ4yeiDeCaKQG3byB135RcqywQrSwrN76bEiRIpHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=TsLA8WZv; arc=none smtp.client-ip=194.105.231.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="TsLA8WZv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1776794561; x=1808330561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5ZPmC/HO+2ljO2Gwx4ByX3/zSSU4ai0L1pfQZaqi4wc=;
  b=TsLA8WZvRzoXfaIH/nksR2cPI/6+3oa96hSRHMlUmZtCoFbHtJRJoYPg
   V2e5InrdcziWr7xfInXheuORIuLPbfvsvbcXNvcsk6fsZEPeVPkmzVzhV
   bC+GvbVhU6sOdctBLetQLb3jF0OC9liQKCXW8lhWiAkrLyEqhfIwZG1Ca
   TRMwX07q0pW49hpS0B7sUFUB2q71iIzRaqAzUFlal7qmiFgCO/lqlfTfH
   ocAhb2xwiTJkpV/td9aBEF9tFYbynswmK06BP5RzoymhT4MQvJWPOxBrh
   bQsvyUlUNxfl77y7ppHmHVTPFK1RZD+1GaHUpTVmURaLnxhCknUY48ZbK
   Q==;
X-CSE-ConnectionGUID: +xiU6Rb/TeqKg7c7M9i2Ig==
X-CSE-MsgGUID: kSMSUY88Q+yrTsGcS+j3rw==
Authentication-Results: smtp-out-05.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 1.9
X-IPAS-Result: =?us-ascii?q?A2FBAwAauudpd9Riq09aHgEBCxIMhFGBB4FqA5ZJnjGBa?=
 =?us-ascii?q?w8BAQEPPRQEAQEDBIILgnSNLyg4EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QYBAQEBAQEGBwIQAUMOO4YJRg2EB4EmAQEBAQEBAQEBAQEBAQEBAQEBFwINg?=
 =?us-ascii?q?T4/SClfgwOCcxSzRIE0gQHePoFqBoFNhXKCZgGKbgI8BoINgUqCRAEBgVaBE?=
 =?us-ascii?q?2UEGH8lAQFfDoV3BIIiehSPAYFKHANZLAFVExcLBwWBZgOBBm4yHYEjPhc0W?=
 =?us-ascii?q?BsHBYFLhg2BC4MvgTstAwttPTcUG4tjIRCBNwOBGgddLFgEP4EXsWWVF4QmB?=
 =?us-ascii?q?YwZlVQzl1IMkw2ZBo4JmziBf4F/LAcaCDCDIlMZD44oiQ2+Z3gCDi8HAgcOA?=
 =?us-ascii?q?pFzB4F4AQE?=
IronPort-PHdr: A9a23:0GtkRhBhcaenxMJlWKgpUyQVQxdPi9zP1m898Z87k/dJb7jmp8mkJ
 03a4/hxyl7SDs3X6PNB3uzRta2oGWkN+o2Iv31KdptQHwQEhsMbk01oAMOMBUDhav+/aSs8E
 ax/
IronPort-Data: A9a23:lULz9ai10IIcumRwU2w8xjlMX161zREKZh0ujC45NGQN5FlHY01je
 htvCDiHOfeDMWCjedBza4Sw8RwF657RzdRlT1ZopXwzEX5jpJueD7x1DG+pZHrKcZeroGGLT
 ik6QoOdRCzhZiKE/n9BCpC48z8kk/3OHuOiYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWQvWo4ow/jb8k034K6r4GlwUmEWPJingnePyRH5M7pHTU2BByOQapVZGOe8W
 9HCwNmRlkvF/w0gA8+Sib3ydEsHWNb6ZWBiXVIPBsBOKjAbzsAD+v5T2Mg0MC+7uB3V9zxF8
 +ihgLTrIesf0gIgr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXAHMdby3dvejx/L+iaeYzjZsGfcixHYxK7xmMzRmBZRonaY7CWLmP995dxC03ltELRauYe
 csCdXxud3wsYTUQaxFOV8t4zbfu3CClG9FbgAv9Sa4f6Wra1gpw0bfFK9vQfNGWA8RO9qqdj
 jOapzugXEFBXDCZ4Tm+10mRt7+fpGDqQr4JO7aDtfwxmkLGkwT/DzVMDgXn8Kbg4qKkYPpaK
 WQJ8TVoprpa3EiqSMTtGgWzoVaasRMGHdldCes37EeK0KW83uqCLnYFVSIEet0jrNUxVS1vj
 gLPgdLyGXpuq9V5VE5x6J/XvTKPZxIfalMPfAwLEgBaxoji+qA820enoslYLEKjsjHiMRDLq
 w1mQQAghq4PyNwK0r2h+kDWxmrx4IbIVRJz5x6/soOZAuFROd/Ni2+AswGzARN8wGCxFQTpU
 J8swJL20Qz2JcvR/BFhuc1UdF1T2xp6DNEsqQQ0QcVwqG3FF4+LZo1W+zg2KUdnWvs5lcvSS
 BaL42t5vcYPVEZGmIcuMupd/exznPC4TbwIl5n8MrJzX3SGXFTZoHoxPBPKhT2FfYpFufhXB
 Kp3uP2EVR4yYZmLBhLtLwvB+dfHHhwD+F4=
IronPort-HdrOrdr: A9a23:cJS9LqB5LRILWhjlHel555DYdb4zR+YMi2TDtnoRdfUxSKelfq
 +V88jzuSWE6wr5IUtQ4+xoYZPwPE80i6QFnrX5TI3NYOCOggLBQb2Ki7GSuAEIcBefygcy79
 YDT0EHMqyIMbCM4PyKhjVRb7wbsby6GOjBv4vjJz0Ed2tXgyAK1XYcNu7zeHcGIzWv5fICZe
 ahDq0unUvZRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3Ab+kmKGoHo6k1QuXqB7T6QZnmUYM1c0CD9n2XH0K?=
 =?us-ascii?q?hKmk2Q+KwGF7K2awxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ANpolkQ3LQ9w50AwrQpeWtaCFjDUj4J+LM308wcU?=
 =?us-ascii?q?/+NieCTdfMAzejm+tXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,192,1770595200"; 
   d="scan'208";a="94071683"
Received: from vist-zimproxy-05.vist.is ([79.171.98.212])
  by smtp-out-05.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 18:01:29 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-05.vist.is (Postfix) with ESMTP id 1AB1720FF5D8;
	Tue, 21 Apr 2026 18:01:29 +0000 (UTC)
Received: from vist-zimproxy-05.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-05.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id nRM4U2hmF0EP; Tue, 21 Apr 2026 18:01:29 +0000 (UTC)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-05.vist.is (Postfix) with ESMTPSA id B41652098B61;
	Tue, 21 Apr 2026 18:01:26 +0000 (UTC)
Date: Tue, 21 Apr 2026 18:01:14 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: linux-pci@vger.kernel.org
Cc: mj@ucw.cz
Subject: Debian maintainer does not forward bug reports
Message-ID: <aee7asxxZ1qzg_EV@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

See

https://bugs.debian.org/cgi-bin/pkgreport.cgi?pkg=pciutils;dist=testing

-.-

  Additional remarks.

  Mails from me to "submit@bugs.debian.org" are no longer acknowledged.  A
Debian maintainer told me, that he would contact the mail administrator
about me not wanting to send bugs upstream.

-.-

From "/usr/share/doc/debian/bug-reporting.txt.gz":

  Don't file bugs upstream

   If you file a bug in Debian, don't send a copy to the upstream software
   maintainers yourself, as it is possible that the bug exists only in
   Debian. If necessary, the maintainer of the package will forward the
   bug upstream.

-.-

  For forwarding bug reports to upstream see:

https://www.debian.org/Bugs/Developer#forward

-.-

  I do not send reports upstream if I have to get an account there.
The Debian maintainers have one already.

  If I get a negative (or no) response from upstream, I send henceforth
bugs to Debian.
