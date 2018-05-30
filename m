Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <bug-199879-41252@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199879-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 30 May 2018 07:41:35 -0700
Message-ID: <CAErSpo5U9D5kmYix2SbcJH_mW8urpmZcgN6Zh=FbGtLch+ACuA@mail.gmail.com>
Subject: Fwd: [Bug 199879] New: Very basic the Pci device is not resumed from
 suspend mode
To: linux-pci@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, linux-kernel, linux-pm]

I'm not sure I understand the problem yet, so please correct me if I'm wrong:

  - Your system has both Nvidia and Intel graphics devices

  - When you use Intel graphics, lspci, lshw, and /proc/bus/pci for
the Nvidia device show invalid data (0xff) after suspend/resume

  - When you use Nvidia graphics, suspend/resume doesn't work (instead
of resuming, you just get a blank screen)

Can you attach the output of "sudo lspci -vv" to the bugzilla, please?

---------- Forwarded message ---------
From: <bugzilla-daemon@bugzilla.kernel.org>
Date: Tue, May 29, 2018 at 1:29 PM
Subject: [Bug 199879] New: Very basic the Pci device is not resumed
from suspend mode
To: <bhelgaas@google.com>


https://bugzilla.kernel.org/show_bug.cgi?id=199879

            Bug ID: 199879
           Summary: Very basic the Pci device is not resumed from suspend
                    mode
           Product: Drivers
           Version: 2.5
    Kernel Version: kernel-4.15.17
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: uzg@wp.pl
        Regression: No

Hi, I have problem with very basic device. Device pci-e not resume from
suspend. Only sleep.

I have a problem with anyone interested in it, because everyone thinks it is
the fault of the device drivers themselves. But this is not a problem.

This device is a basic device. I've already installed drivers on various
hardware and it has always been ok, but not this time.

I'm an electronics technician. After diagnosing what I managed, in my opinion
the device remains asleep.

Where does my application come from?
I have multiuser mode and I do not use this device. After suspend lspci and
lshw show normal data. Normal data is in /proc/bus/pci/...
Next suspend and resume, and...
lspci see hardware, but is error
lshw see hardware as undefined device
data in /proc/bus/pci/... is only 0xFF
Hardware sleep, not work, not ready. This is bug.

But since the problem concerns the graphics card in the configuration with the
second default Intel card, everyone thinks that this is another driver problem
as always and nobody wants to take a look at it :(

The problem is easy to recognize. On the internet, I've seen a lot of
unresolved problems in which I could see exactly what I found.

My hardware is Lenovo with NVidia and Intel Graphics. Problem is with NVidia. I
tested Z710 and Z50-70. The first symptom of the problem is lspci in multiuser
mode (or when is XServer with intel graphics). After suspend NVidia have e.g
"rev. A1", after resume is "rev. FF". Next symptom lshw and /proc/bus/pci/...
When system started with normal NVidia driver, system not resume and halt, only
black screen.

There are many examples on the Internet with unsolved problems e.g
https://www.lwks.com/index.php?option=com_kunena&func=view&catid=21&id=124374&Itemid=81

--
You are receiving this mail because:
You are watching the assignee of the bug.
