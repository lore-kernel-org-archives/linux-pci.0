Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Mar 2017 09:47:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: lkml@pengaru.com, "Bowers, AndrewX" <andrewx.bowers@intel.com>,
        "Brown, Aaron F" <aaron.f.brown@intel.com>,
        "vcaputo@pengaru.com" <vcaputo@pengaru.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        David Singleton <davsingl@cisco.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        khalidm <khalidm@cisco.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Subject: Re: [Intel-wired-lan] [BUG] 4.11.0-rc1 panic on shutdown X61s
Message-ID: <20170324084758.wg5yuf2c3mi46nhd@pd.tnic>
References: <CAHp75Ve7SWivf=TTuq-qA=iM20E==OmSZD2YAmt0LVJQg47Osg@mail.gmail.com>
 <20170312222333.hm54nl2ul5iuixap@pd.tnic>
 <87shmhjfap.fsf@miraculix.mork.no>
 <309B89C4C689E141A5FF6A0C5FB2118B8C5B3F9B@ORSMSX101.amr.corp.intel.com>
 <20170314024033.GK802@shells.gnugeneration.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A10402F44@ORSMSX101.amr.corp.intel.com>
 <20170322020445.GD802@shells.gnugeneration.com>
 <20170322021343.GE802@shells.gnugeneration.com>
 <20170322190019.GB20697@nazgul.tnic>
 <CAL3LdT6CbZkyngugiPCqhNvT02tsTWsWfMT4KH41hrAEE3evAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAL3LdT6CbZkyngugiPCqhNvT02tsTWsWfMT4KH41hrAEE3evAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 23, 2017 at 11:18:31PM -0700, Jeff Kirsher wrote:
> I have sent a patch to revert this offending commit through David
> Miller's net tree, sorry for the delay on this, I thought I had seen a
> patch to revert the offending commit earlier which is why I did not
> send this earlier.

Thanks Jeff. If you need me to test the real fix just let me know.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
