Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6064D0CF8;
	Fri,  9 Oct 2026 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545775; cv=none; b=Td/Y1pwAktJcP0z255AoVCkP4oTIyYbiTNbjDKC/SyrUPHG8KwxVZAIMN3i+u2zzb4E+xJPqTTW32Q7EcNpflobR3hgxmFK70BRwGmAW+5w2AQcZcFYM+PAMAU79O3bKFLsprz8hZprvog75hnyobjbFRv6iWc4iRjz3fAwmpkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545775; c=relaxed/simple;
	bh=JlnCd2TfwnI4qtAiVgUVZkbu8ICfs8xqWzEE7rFgv64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPJWBbLScBaIhB7OMhTdXIC+28k3r1DrYCYa/Pd+dDXeC1MUwY6sP45/geWoKb1sSAQGaRFRf/k2rXY+1x4bUa/Hob+9OnXUq4v04F22Ml3Fj0pyMfb6+oUMqeFu5Tiba9WJspIEQvzkPJrYLS9pqhEW69j/7u1tsy7Sn0ofagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id ED779479BC;
	Fri, 09 Oct 2026 13:36:03 +0200 (CEST)
Message-ID: <19cdc3df-fcdc-405d-be05-d018b09932d9@proxmox.com>
Date: Fri, 9 Oct 2026 13:36:02 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
To: M M <restafvalendergelijke@outlook.com>,
 "armando.araujo@syncnow.net" <armando.araujo@syncnow.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "regressions@leemhuis.info" <regressions@leemhuis.info>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <DU2PPFBE35756D171CD64356C8D8DF3C2F8AB922@DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-US, de-DE
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
In-Reply-To: <DU2PPFBE35756D171CD64356C8D8DF3C2F8AB922@DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791545763101

On 09/10/2026 12:53, M M wrote:
> Thank you Armando for the detailed follow-up. It's "good" to see this problem is still active, though Proxmox is really slow with this. In the meantime we are 1,5 month ahead and without the much needed security updates related to the kernel.
> I can only hope there will be some progress soon on their behalf, but it's pretty much quiet at Proxmox in general.

Please stop CC'ing random people and Proxmox email addresses that half
not even exist, that's just spamming, please stop that. Also not sure
what your talking w.r.t. security updates, we release fixes in our kernel
on a steady stream and are up-to-date here.

Besides, our downstream info about this was that one user tried the patch
and it did not work for them and you could not confirm this either as
requested in the same reply telling you [0], so we did not look at this
at all due to waiting on feedback. btw. did you actually test this now
confirming it fixes the issues on your system?
As v3 on its own would leave most of our reports broken, revert is more
likely to help here for the broader masses and will be the route we
look into.

[0]: https://bugzilla.proxmox.com/show_bug.cgi?id=7969#c8

