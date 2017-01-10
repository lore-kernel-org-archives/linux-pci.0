Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH] xen: do not re-use pirq number cached in pci
 device msi msg data
To: Dan Streetman <ddstreet@ieee.org>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20170105192856.25559-1-dan.streetman@canonical.com>
 <20170107010651.GV16608@char.us.oracle.com>
 <42d912c2-596e-29f6-8385-dc82a891895c@oracle.com>
 <CALZtONBNhh9WKPV16+cod-P1Fp2YudTkVzHQZMq81_NEne67pA@mail.gmail.com>
 <20170109155929.GA10991@char.us.oracle.com>
 <alpine.DEB.2.10.1701091049130.2866@sstabellini-ThinkPad-X260>
 <CALZtONDSD6SF9cd2uftGWsXARF-QiNaBA5zPdnjwQ7j0Z-C76g@mail.gmail.com>
 <CALZtONBJ=kjsKiKtLORxBq3Xn6=SV7+33GAkSi+3cqjs9wVW2g@mail.gmail.com>
 <alpine.DEB.2.10.1701101046270.8205@sstabellini-ThinkPad-X260>
 <CALZtONAuMvFP-GX801k1Cy=ja_65PDWO2ZXfSof-1mGfhV=Pew@mail.gmail.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Streetman <dan.streetman@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <d2715827-2146-2de3-cd1b-186a4b67ca05@oracle.com>
Date: Tue, 10 Jan 2017 18:28:26 -0500
MIME-Version: 1.0
In-Reply-To: <CALZtONAuMvFP-GX801k1Cy=ja_65PDWO2ZXfSof-1mGfhV=Pew@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


>> In the Xen code I can still see:
>>
>>     case ECS_PIRQ: {
>>         struct pirq *pirq = pirq_info(d1, chn1->u.pirq.irq);
>>
>>         if ( !pirq )
>>             break;
>>         if ( !is_hvm_domain(d1) )
>>             pirq_guest_unbind(d1, pirq);
>>
>> which means that pirq_guest_unbind should only be called on evtchn_close
>> if the guest is not an HVM guest.

A few lines further down we have:

        pirq->evtchn = 0;
        pirq_cleanup_check(pirq, d1);
        unlink_pirq_port(chn1, d1->vcpu[chn1->notify_vcpu_id]);
#ifdef CONFIG_X86
        if ( is_hvm_domain(d1) && domain_pirq_to_irq(d1, pirq->pirq) > 0 )
            unmap_domain_pirq_emuirq(d1, pirq->pirq);
#endif

which is where we free up the pirq.

-boris
