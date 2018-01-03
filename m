Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0121.outbound.protection.outlook.com ([104.47.37.121]:20915
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750864AbeACRwm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jan 2018 12:52:42 -0500
From: Casey Leedom <leedom@chelsio.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: Does anyone know of a problem with Write Combined Buffer support
 CentaurHauls?
Date: Wed, 3 Jan 2018 17:52:39 +0000
Message-ID: <CY1PR12MB0344ACC997D35AFDD2F00946C81E0@CY1PR12MB0344.namprd12.prod.outlook.com>
References: <SN1PR12MB03527687B2D1DC3DD12E8FEBC80D0@SN1PR12MB0352.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB03527687B2D1DC3DD12E8FEBC80D0@SN1PR12MB0352.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

| From: Casey Leedom
| Sent: Thursday, December 21, 2017 11:15 AM
|
|     We have a problem with a system which ~seems~ to be pointing at a bro=
ken
| Write Combined Buffer implementation.  Our chip seems to be getting garba=
ge
| data instead of incomplete Write Combined Merging Transaction Layer Packe=
ts.
| We'll go ahead and put the beast on a PCIe Analyzer to verify this, but I
| thought I'd ask if anyone else had already stumbled across this.

  So, everyone's back from the holidays now, eh?

  Looking through arch/x86/kernel/cpu/centaur.c I can't seem to find anyone
who's been taking a long-term support role, nor do I see anyone in
MAINTAINERS.

  Anyone have any idea who I could contact about this?

Casey
