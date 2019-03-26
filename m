Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE167C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 02:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC71020811
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 02:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="STiKyYYw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MUZA8UkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfCZC1F (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:27:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33735 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbfCZC1E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 22:27:04 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 28FC322E76;
        Mon, 25 Mar 2019 22:27:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 25 Mar 2019 22:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=GLaTIU9WH7pq5hbeGJ4+7kivvIo
        zCQ7QosT6yxfBZT8=; b=STiKyYYwHPzMYz/8a9vzrbKb8R1iLmTXBTbFe1Dlzx6
        4xKr/seG+roBRhPnl7szLaI33MAt9tDI889CCDHBZ8gs2lPAPdvNCBUiwpDgR23C
        tL1I62/+Wr1ayCSKLTE6OwIL2WwfMK0LB/jQJoan9HoWfKEBWCxvSdicMo9N+BPk
        Hx3IPgVKZpb0aif5YpXauGibEFFQllbaxyowl32l+h1rSDUoHvZFaFTPviZXnakp
        dCh3tV/5Vnf6slkVlq8sirToWqaeewU6SWqpVWwFL9J814/n7HvF1MJm9iFORAau
        OyPtoBdBjz9LiCYQ/uFlZO66D9/6q5Zxwx3zeiD+BPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=GLaTIU
        9WH7pq5hbeGJ4+7kivvIozCQ7QosT6yxfBZT8=; b=MUZA8UkW53XZG+TUg7uUXM
        BW+KIeClQ6da4LqKyDmXcD5WQfpeKucJlTqeixeFmmArmAsXGwZFKQi01q7b4DVQ
        lBS+oL0eeBMyiFz2LWrTWgG4JN8O2B4SaIe6VpLCOml7yksiA5d6lpMcNf+G2ACw
        x6dlRxduBen/v9GyfzqUqytPvBVOOtPOCtxoXaTpYt6xKHXp0PZHIwr6Glp2ds2P
        /TX+F3mbONDXk4eFqeeNdbkGlB0dEaj5Z3FW5T00zzC5ypjQwAlwpW/MKNAI8uVk
        6Dmy7G0HsSV67APmoVWNpMwumRJ5vWAWLURc0DoPMPCtbxs0ypG4JJlmyhCOKrng
        ==
X-ME-Sender: <xms:8o2ZXND8QyHu9HRvrxZSXtAwqZO2gkUadbttJh2uei6VDrio4Sdhcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrjeelgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepudejvddruddtgedrvdegke
    drgeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:8o2ZXH8FZZLHdMCQhSwTv9DB9iptCwBCyV_4kCYogctbqRz8iwgpSQ>
    <xmx:8o2ZXP275VVqhbUWMZ92bz4VqNWNUiAe7a21VZoOIg-3I0N9lGb49A>
    <xmx:8o2ZXOR0R2pqW7vemW7bWru1n-nxEse0apO7QJWK21WI7APEPWSH3A>
    <xmx:942ZXJ0UUFpuZoOuqng_fK8-uYZG1eCIQTFgYnamfofTsZZX8aOLeg>
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6766DE442F;
        Mon, 25 Mar 2019 22:26:57 -0400 (EDT)
Date:   Tue, 26 Mar 2019 11:26:52 +0900
From:   Greg KH <greg@kroah.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [BACKPORT 4.14.y 0/8] candidates from spreadtrum 4.14 product
 kernel
Message-ID: <20190326022652.GB19395@kroah.com>
References: <20190322161727.1153278-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322161727.1153278-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 22, 2019 at 05:17:15PM +0100, Arnd Bergmann wrote:
> I took a scripted approach to look at some product kernels for patches
> backported into vendor kernels. This is a set of (mostly) bugfixes I found
> in Spreadtrum's linux-4.14 kernel that are missing in v4.14.107:
> 
> 83dc7e3dea76 scsi: ufs: fix wrong command type of UTRD for UFSHCI v2.1
> 099a95f3591a PCI: designware-ep: dw_pcie_ep_set_msi() should only set MMC bits
> 1cab826b30c6 PCI: designware-ep: Read-only registers need DBI_RO_WR_EN to be writable
> b330104fa76d PCI: endpoint: Use EPC's device in dma_alloc_coherent()/dma_free_coherent()
> 36d46cdb43ef rtc: Fix overflow when converting time64_t to rtc_time
> 1b5d43cfb697 sched/cpufreq/schedutil: Fix error path mutex unlock
> 5fb5caee92ba pwm-backlight: Enable/disable the PWM before/after LCD enable toggle.
> f25a646fbe20 power: supply: charger-manager: Fix incorrect return value
> 
> Only a small number of patches here, the vendor tree is fairly close to
> mainline. All commits apply cleanly through git-cherry-pick.

Thanks for these, now queued up to 4.14.y and a few other branches that
needed them.

greg k-h
