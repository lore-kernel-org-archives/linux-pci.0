Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A4CC4743C
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jun 2021 23:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD15B613FF
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jun 2021 23:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFDX2w (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jun 2021 19:28:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:8183 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhFDX2w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 19:28:52 -0400
IronPort-SDR: er29U5Re3b6ooSwlQvqp1nNdFDXTpvuyoF9XskSckJWtOeayRP+UqHpvg/LiZFd7d3HNWRpKhH
 hFTjl+O3yiTA==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="225710320"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="225710320"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 16:27:05 -0700
IronPort-SDR: iAVDE/vmAqWrvAWl48ex59qbScDCEaekDl0uyq15IBJD25YOLL6WcIpKmrVPBxNFjIykVlcpCZ
 bO7fXjtuF8mQ==
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="448429786"
Received: from lmrivera-mobl.amr.corp.intel.com (HELO vcostago-mobl2.amr.corp.intel.com) ([10.251.24.65])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 16:27:04 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     intel-wired-lan@lists.osuosl.org, sasha.neftin@intel.com,
        anthony.l.nguyen@intel.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, netdev@vger.kernel.org, mlichvar@redhat.com,
        richardcochran@gmail.com, hch@infradead.org
Subject: Re: [PATCH next-queue v4 1/4] Revert "PCI: Make pci_enable_ptm()
 private"
In-Reply-To: <20210604222542.GA2246166@bjorn-Precision-5520>
References: <20210604222542.GA2246166@bjorn-Precision-5520>
Date:   Fri, 04 Jun 2021 16:27:04 -0700
Message-ID: <87bl8lxlbr.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Jun 04, 2021 at 03:09:30PM -0700, Vinicius Costa Gomes wrote:
>> Make pci_enable_ptm() accessible from the drivers.
>> 
>> Even if PTM still works on the platform I am using without calling
>> this function, it might be possible that it's not always the case.
>
> Not really relevant to this commit, strictly speaking.
>

Will remove then.

>> Exposing this to the driver enables the driver to use the
>> 'ptm_enabled' field of 'pci_dev' to check if PTM is enabled or not.
>> 
>> This reverts commit ac6c26da29c12fa511c877c273ed5c939dc9e96c.
>
> Ideally I would cite this as ac6c26da29c1 ("PCI: Make pci_enable_ptm()
> private") so there's a little more context.
>

Yeah, that looks better.

Will follow the suggestions you made in the next patch as well and send
another version, thanks.


Cheers,
-- 
Vinicius
