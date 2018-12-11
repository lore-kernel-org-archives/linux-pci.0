Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27855C6783B
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 18:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB09C2086D
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544552792;
	bh=kA9X+sem61rCdq43x7UECU9CTHERwjEDLE8pMutGRko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kNsndeFu+TTXCTA5dksErResyIpzmurvFI8iOPP5Xp1jaZmWTOtn3K06vjDD6i+oa
	 lPjScJgvtbRc1u5H5poP1Am/KliHzUjbVMi7iD/2Wci+v36/cjCSSG5ftwGX72XIHB
	 ZReTQAFDPollLdrQ7iJ0KMm7Fcrm/0zjo46UGrjk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB09C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeLKS0c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:26:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeLKS0c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 13:26:32 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43EA820851;
        Tue, 11 Dec 2018 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544552791;
        bh=kA9X+sem61rCdq43x7UECU9CTHERwjEDLE8pMutGRko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=copSHamRvYhLWUO6ckNbyTsEeNSMZBJcBwQh9KVjkhmzI5MsXHAyD7sGoF4LQBwkB
         idZTT6YeX0yKMqQLXWnuVsWzTsV5j57yFg7FDu+Kl2WE0tvqYUYgzEABdgB8C96d70
         Az7W0moxhAbuOlaVeoIJ/W2i5fmjKYEhzoZ5ijqw=
Date:   Tue, 11 Dec 2018 12:26:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Mertarg10@gmail.com" <Mertarg10@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fran RR <fjrr87@outlook.com>
Subject: Re: Fwd: [Bug 201647] New: Intel Wireless card 3165 does not get
 detected but bluetooth works
Message-ID: <20181211182630.GF99796@google.com>
References: <bug-201647-193951@https.bugzilla.kernel.org/>
 <CABhMZUXc4FS-f52ZDsErEhbkm_jjEz+kn75YO5Tuvp42Qm+1xw@mail.gmail.com>
 <20181128211959.GB178809@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB3013373E4A3@HASMSX112.ger.corp.intel.com>
 <20181210222452.GC85090@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB30133754C00@HASMSX112.ger.corp.intel.com>
 <20181211135121.GB99796@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB30133756A29@HASMSX112.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0BA3FCBA62E2DC44AF3030971E174FB30133756A29@HASMSX112.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 11, 2018 at 04:32:25PM +0000, Grumbach, Emmanuel wrote:
> > On Tue, Dec 11, 2018 at 06:35:20AM +0000, Grumbach, Emmanuel wrote:
> > > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=201647
> > 
> > > FWIW: I saw another problem like this with a 9650 device.
> > 
> > Do you have a pointer to any info about this 9650 issue?  Maybe that would
> > have a clue.
> 
> I added him here so that you can ask whatever you like :)
> The story is the same. I am attaching a picture I got from the reporter.
> I can confirm that this device ID / subdevice ID is supported by the linux driver.

Was there a resolution, i.e., if somebody figured out how to make the
9650 wifi work, maybe a similar solution would work for the 3165?
